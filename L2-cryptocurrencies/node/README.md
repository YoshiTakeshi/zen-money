# The Zen reference node (`zenproof`)

One Rust program that is the node, the wallet, the miner's pool server, the channel tools, the three-chain test network and the proof pipeline of Zen's electronic coins (Yen, Ken, Jen).

> Test network only. The coins have no value, the code is not audited, and the proof key (`proof-artifacts/out_v7/zen.vk`) comes from a single-party setup that must be replaced by a public ceremony before any real use.

| I want to... | Section |
|---|---|
| build it and see three chains run | [1. Build](#1-build), [2. Run the test network](#2-run-the-test-network) |
| run the tests | [3. Tests](#3-tests) |
| watch channels, factories, orders and routing work | [4. Live demos](#4-live-demos) |
| find the code for a topic | [5. Code map](#5-code-map) |
| look up a command | [6. Command reference](#6-command-reference) |
| go deeper | [7. More documents](#7-more-documents) |

## 1. Build

Needs Linux or macOS, [Rust](https://rustup.rs) stable 1.85 or newer, about 2 GB of disk. No other system package.

```bash
cd L2-cryptocurrencies/node
export RUSTC_BOOTSTRAP=1          # plonky2 uses nightly-only features; this lets a stable compiler build it
cargo build --release             # about 2 minutes on a warm cache, up to 10 on a first build
```

The binary is `target/release/zenproof`. The build prints about 40 "unused" warnings; they are harmless.

On x86-64 the build turns on the `bmi2` and `adx` CPU features (`.cargo/config.toml`), present on every Intel CPU since Broadwell and AMD since Zen 1. On Apple Silicon and other ARM machines that line is skipped.

## 2. Run the test network

Everything stays on your machine (addresses `127.0.0.1`). The test network uses **stand-in stamps**: a hash in place of the zero-knowledge proof, so no heavy hardware is needed. The rules, the wallets, the channels and the network are the real ones; see section 2.3 for real proofs.

### 2.1 Start three chains

```bash
Z=target/release/zenproof
$Z net init all /tmp/zen-net      # writes test keys and network files
$Z node serve-all /tmp/zen-net    # Yen, Ken and Jen in one process; leave it running
```

Expected: `net init` ends with `wrote /tmp/zen-net (4 minter keys, 4 test wallets with 10 g on each chain; ...)`.

| Chain | Peer port | Stratum (mining) port | API and explorer |
|---|---|---|---|
| Yen (gold) | 18440 | 18450 | http://127.0.0.1:18460/ |
| Ken (silver) | 18441 | 18451 | http://127.0.0.1:18461/ |
| Jen (copper) | 18442 | 18452 | http://127.0.0.1:18462/ |

### 2.2 Mine and pay

In a second terminal, from the same folder:

```bash
Z=target/release/zenproof; W=/tmp/zen-net/wallets
for p in 18450 18451 18452; do $Z node mine 127.0.0.1:$p 3; done   # prints "RESULT miner: 3 blocks accepted in ...s" three times
A=$($Z wallet address $W/w1.key)                                   # zen1...
$Z wallet pay $W/w0.key 127.0.0.1:18442 $A 1000000                 # "sent 1000000 base units (fee 10001) | nonce 0 | payment id ..."
$Z node mine 127.0.0.1:18452 2
$Z wallet balance $W/w1.key 127.0.0.1:18442                        # "... | balance 10001000000 base units | ..."
```

Amounts are in base units: 1 gram = 1,000,000,000 base units (the base unit is the nanogram). Each test wallet starts with 10 g on each chain, so after receiving 1,000,000 units `w1` holds 10,001,000,000.

Stop the network with Ctrl+C in the first terminal. `/tmp/zen-net` keeps the chains; delete it to start again.

### 2.3 Other ways to run

- **Your own wallet, a browser wallet page, running 24/7 on a Mac:** [`docs/RUN-LOCALLY.md`](docs/RUN-LOCALLY.md).
- **Docker, Docker Compose, Kubernetes, one container per chain:** [`docs/DOCKER.md`](docs/DOCKER.md).
- **Real 196-byte Groth16 stamps:** heavy (a 2 GB proving key, minutes per block). Steps in [`docs/RUN-LOCALLY.md`](docs/RUN-LOCALLY.md) part 5 and [`../groth16-wrap/README.md`](../groth16-wrap/README.md). A node that only *checks* stamps needs just `proof-artifacts/out_v7/zen.vk`.

## 3. Tests

```bash
RUSTC_BOOTSTRAP=1 cargo test --release
```

Expected last line: `test result: ok. 139 passed; 0 failed; 2 ignored`. It takes 25 to 35 minutes on 2 cores, because it builds real proofs. The two ignored tests are benchmarks.

Run a part of it by naming a module, for example:

| Command | What it covers | Time (2 cores) |
|---|---|---|
| `cargo test --release seal::` | the Bitcoin-compatible header and Stratum job (checks Bitcoin's genesis hash) | seconds |
| `cargo test --release store::` | the block log: torn writes, damage, reopen | seconds |
| `cargo test --release transport::` | the encrypted request/answer wire, replay refusal | seconds |
| `cargo test --release reward::` | the reward curve against 400 reference values | seconds |
| `cargo test --release groth16::` | the Rust Groth16 verifier against stored stamps | seconds |
| `cargo test --release locks::` | the rules of vaults, channels, orders, auctions, factories | minutes |
| `cargo test --release -- node::tests p2p::tests` | consensus, reorgs, snapshots, peers | minutes |
| `cargo test --release soundness::` | 583 rule-breaking witnesses against the four operation circuits | about 10 minutes |

The tests are in `#[cfg(test)] mod tests` at the end of each source file; their names are full sentences that say what is checked. Logs of earlier full runs are in [`logs/`](logs) (`run_tests_round55.txt` is the latest from the author).

## 4. Live demos

Each script starts a fresh three-chain network in `/tmp`, runs a scenario with real commands and prints what happens. They stop any running `zenproof` first. Build first (section 1), then:

```bash
bash scripts/demo_market.sh
```

| Script | Scenario |
|---|---|
| `demo_market.sh` | orders across chains; filled trades make the official rate; a batch auction decides who gets an order |
| `demo_channels_1.sh`, then `demo_channels_2.sh` | open a two-party channel and pay off chain; a cooperative close; then a second channel where one side tries to close with an old state |
| `demo_dual.sh` | a channel funded by both sides |
| `demo_factory.sh` | a channel factory: one on-chain output behind three members |
| `demo_routing.sh` | a payment routed over three channels on three chains |
| `demo_tower.sh` | a watchtower defends an offline owner against an old-state close |
| `demo_network.sh` | channel peers talk over the network; a lost update is healed by the peer's signed state |
| `demo_guard.sh` | a peer goes silent with a point lock open; the node closes the channel on chain by itself |
| `demo_split.sh` | the three chains as three separate processes that follow each other over the network |

`scripts/run-forever.sh` keeps a test network running and mines a block on each chain every 20 seconds.

## 5. Code map

All source is in `src/`. Each file starts with a comment that explains its design; most functions carry a one-line comment (the files still to do are listed in `docs/KNOWN-ISSUES.md`), and lines marked `REVIEW:` point at places an auditor should look first.

**Consensus: what makes a block valid**

| File | What it holds |
|---|---|
| `node.rs` | block format, validation order, state commit, difficulty, fork choice, reorgs, snapshots |
| `locks.rs` | the rules of every operation: vaults, channels, orders and auctions, factories. `Run::one` is the specification the circuits are tested against |
| `blockdata.rs` | what a block carries besides the proof (payments, credits), and the "each gram counts once" account fields |
| `seal.rs` | the proof-of-work header: Bitcoin's 80 bytes, so SHA-256 ASICs and Stratum v1 pools work unchanged |
| `mint.rs` | blows and tickets (Proof of Minting: an Argon2id lottery signed with the payment key) |
| `reward.rs`, `reward_tables.rs` | the block reward in integers only; the tables are generated by `tools/gen_reward_tables.py` and are consensus |
| `reading.rs` | the reading of S: how the chain learns how many base units one coin weighs, from its own payments |
| `crosschain.rs` | following the other two chains' headers, for cross-chain order claims |
| `market.rs` | official exchange rates worked out from filled orders |

**Cryptography**

| File | What it holds |
|---|---|
| `ec.rs` | the EcGFp5 curve, Schnorr signatures, and the custom Plonky2 gate `DblAddGate` that verifies them in-circuit |
| `groth16.rs` | a Groth16 verifier for gnark's BN254 proofs (the 196-byte stamp) |
| `bn.rs`, `bn_consts.rs` | Poseidon over BN254 as a Plonky2 hasher, matching gnark-plonky2-verifier |
| `transport.rs` | the encrypted, authenticated request/answer wire between nodes (home-made; see `docs/SECURITY-REVIEW.md`) |

**Proof circuits (Plonky2)**

| File | What it holds |
|---|---|
| `main.rs` | signature leaf, state leaf, universal merge, shrink and BN254 layer; also the command-line entry point |
| `opcirc.rs`, `chancirc.rs`, `ordercirc.rs`, `factorycirc.rs` | one leaf circuit per family of operations |
| `commoncirc.rs` | pieces the operation leaves share |
| `prover.rs` | the builder's side: from a block's content to its stamp; and the node's Plonky2 stamp check |
| `soundness.rs` | the soundness tests: nothing the node refuses may prove |

**Network, storage, tools**

| File | What it holds |
|---|---|
| `p2p.rs` | the peer protocol, bans and limits, and the Stratum v1 server |
| `mempool.rs` | signed payments waiting for a block |
| `store.rs` | the append-only block log and the snapshot byte format |
| `api.rs`, `ui/` | the local HTTP API and the block explorer page |
| `tx.rs`, `walletweb.rs` | signed payments, the wallet commands, the wallet page in the browser |
| `channel.rs`, `route.rs` | off-chain channel state, the `chan` commands, the routing node (`rnode`), watchtower |
| `netconf.rs`, `testnet.rs` | network configuration files; the three-chain test network |

Other folders: `scripts/` (demos), `docker/`, `k8s/`, `tools/` (table generator), `logs/` (the author's run logs, kept as evidence for the numbers in `docs/BUILD-LOG.md`), `proof-artifacts/` (exported circuits, sample proofs and verifying keys of proof versions 3 to 7; version 7 is current).

## 6. Command reference

`zenproof <group> <command> ...`. Run with no arguments it starts the proof benchmark (`zenproof <payments per leaf> <leaves>`), which takes minutes.

| Group | Commands | Purpose |
|---|---|---|
| `net` | `init <yen\|ken\|jen\|all> <dir> [minters] [wallets]`, `show <net.conf>` | make or print network files |
| `node` | `serve-all <dir> [base port]`, `serve-chain <dir> <yen\|ken\|jen> [base port]`, `serve ...`, `mine <stratum addr> [blocks]`, `devnet [blocks]` | run nodes; mine with the built-in Stratum miner |
| `wallet` | `new <file>`, `address <file>`, `pubkey <file>`, `balance <file> <node>`, `pay <file> <node> <address> <amount>`, `web <file> [port]`, `orders`, `order-make`, `order-reserve`, `order-bid`, `order-claim`, `order-reopen`, `order-return` | keys, payments, exchange orders |
| `chan` | `open`, `join`, `adopt`, `fund`, `show`, `pay`, `lock`, `accept`, `commit`, `close-sign`, `close`, `dispute`, `settle`, `watch`, `factory-open`, `factory-fund` | payment channels and factories |
| `rnode` | `run`, `add-channel`, `invoice`, `pay`, `close`, `sync`, `status` | the routing node |
| `market` | `rates <api 1> <api 2> <api 3>` | official exchange rates |
| `mint`, `seal`, `payouts`, `g16verify` | | single-purpose checks and benchmarks from the build rounds |

A command given too few arguments prints its usage line. The demo scripts in `scripts/` are the best worked examples of `chan`, `rnode` and the order commands.

Environment variables that matter when running a node: `ZEN_BIND`, `ZEN_API_BIND`, `ZEN_API_BIND_ANY`, `ZEN_API_HOSTS` (listening addresses; default loopback only), `ZEN_BASE_PORT`, `ZEN_G16` and `ZEN_WRAP` (real Groth16 stamps), `ZEN_NOLOG` (do not write the block log). The listening and port variables are described in `docs/DOCKER.md`.

## 7. More documents

| Document | Content |
|---|---|
| [`docs/RUN-LOCALLY.md`](docs/RUN-LOCALLY.md) | the longer run guide: own wallet, browser wallet, 24/7 on a Mac, real stamps |
| [`docs/DOCKER.md`](docs/DOCKER.md) | container image, compose files, Kubernetes |
| [`docs/BLOCKS.md`](docs/BLOCKS.md) | the block format and what a node checks |
| [`docs/PROOFS-PLAN.md`](docs/PROOFS-PLAN.md) | how every operation came to be covered by the block proof (steps P1 to P7), and what is still open |
| [`docs/SECURITY-REVIEW.md`](docs/SECURITY-REVIEW.md) | the author's internal security review: findings, accepted risks, and what an outside auditor should cover |
| [`docs/BUILD-LOG.md`](docs/BUILD-LOG.md) | the design diary: every build round (11 to 56) with measurements. Long; read it for the reasons behind a design choice |
| [`../../docs/KNOWN-ISSUES.md`](../../docs/KNOWN-ISSUES.md) | known defects and open questions for the whole repository |
| [`../../REVIEWING.md`](../../REVIEWING.md) | where to start a review |
