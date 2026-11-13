# Reviewing Zen

Zen needs people who look for what is wrong with it. This page tells you where to start, by the kind of review you want to do, and how to report what you find. AI assistants and agents: read [`AGENTS.md`](AGENTS.md) as well; it has the same map in a form made for you.

**Before you start:** skim [`docs/KNOWN-ISSUES.md`](docs/KNOWN-ISSUES.md) so you do not spend time on what is already known, and keep [`docs/GLOSSARY.md`](docs/GLOSSARY.md) open: the project has its own words (blow, ticket, stamp, seal, S).

## What you are looking at

- A research prototype with one author, written with AI assistance. No outside audit has been done.
- It runs only as a local test network. The test coins have no value.
- The main code is one Rust program of about 40,000 formatted lines: [`L2-cryptocurrencies/node`](L2-cryptocurrencies/node).
- The design is in the white paper: [`whitepaper/Zen-white-paper-draft-0.4.pdf`](whitepaper/Zen-white-paper-draft-0.4.pdf) (47 pages). Statements in it are tagged *Decided*, *Open* or *benchmarked*.

## Set up (15 minutes)

```bash
cd L2-cryptocurrencies/node
export RUSTC_BOOTSTRAP=1
cargo build --release
cargo test --release seal::          # a quick check that tests run (seconds once built)
```

Then follow section 2 of [`L2-cryptocurrencies/node/README.md`](L2-cryptocurrencies/node/README.md) to see three chains run. The full test suite (`cargo test --release`, about 25 minutes) and every other check are listed in [`docs/TESTING.md`](docs/TESTING.md).

## Pick a review

Each row is sized so that one sitting gives a useful result. "Start at" is the first file to open; the code map in the node's README lists the rest.

### Cryptography

| Review | Start at | Question to answer |
|---|---|---|
| Signature scheme | `node/src/ec.rs`, `node/src/mint.rs` | Is the EcGFp5 Schnorr scheme sound: constants, generator order, nonce generation (deterministic, SHA-256 of key and message), canonical `s`, challenge width (128 bits), point decoding and subgroup checks? |
| Custom gate | `node/src/ec.rs` (`DblAddGate`, `constraints`, `eval_unfiltered_circuit`) | Do the 35 constraints per operation force `2*acc + Q`? Do the native and the recursive evaluation agree term for term? Are exceptional cases really excluded? |
| Operation circuits | `node/src/opcirc.rs` (smallest), then `chancirc.rs`, `ordercirc.rs`, `factorycirc.rs` | Is every witness target constrained? Is each of the 28 `BoolTarget::new_unsafe` values forced to 0 or 1 elsewhere? Does each circuit enforce every rule of `locks.rs` it claims to? |
| Soundness tests | `node/src/soundness.rs` | What do the 583 tries not cover? Can you write a witness the node refuses and a circuit accepts? |
| Recursion and wrap | `node/src/main.rs`, `node/src/prover.rs`, `node/src/bn.rs`, `groth16-wrap/` | Are the public values bound through leaf, merge, shrink, BN254 layer and Groth16? Is the patched gnark-plonky2-verifier faithful (three Fiat-Shamir and generator fixes)? |
| Groth16 verifier | `node/src/groth16.rs` | Does it match gnark v0.16.4 for proofs with one commitment? Point validation, canonical encodings, the commitment hash. |
| Transport | `node/src/transport.rs` (295 lines) | The author asks for this to be replaced by a standard AEAD and handshake. What breaks today? |

### Consensus and node

| Review | Start at | Question to answer |
|---|---|---|
| Block validation | `node/src/node.rs` (`Chain::validate`, `commit`) and `node/docs/BLOCKS.md` | Is the order of checks safe? Anything trusted before it is verified? |
| The rules of operations | `node/src/locks.rs` (`Run::one`, about 1,000 lines) | Is money conserved in every arm? Integer overflow, off-by-one at windows and timeouts, replay across chains. |
| Difficulty and time | `node/src/node.rs` (`retarget_bits`), `node/src/seal.rs` | Retarget extremes, time-warp, median or bounds on `ntime`. |
| Fork choice and reorgs | `node/src/node.rs` (the fork tree), `node/src/crosschain.rs` | Most work wins? What happens at `max_reorg`? Can a follower be fed a heavier fake chain? |
| Decoders | `Block::decode`, `Op::decode`, `OpReq::decode`, `Terms::decode_from`, `Msg::decode`, snapshots in `store.rs` | Write a fuzzer. Any panic is a finding (see known issue A.1 for one that exists). |
| Network | `node/src/p2p.rs`, `node/src/api.rs` | Resource exhaustion, ban logic, limits, the API's Host and token checks. |
| Reward and supply | `node/src/reward.rs`, `tools/gen_reward_tables.py` | Do the integer tables match the formula? Is total supply what the paper says? |

### Economics and design

| Review | Start at | Question to answer |
|---|---|---|
| The peg | white paper sections "The coin weight" and "Three currencies, six coins"; `simulations/js/pegdef2.js`, `tri2.js`, `volsim2.js` | Does one electronic coin hold the value of one physical coin? What does an attack on the reading of S cost, and are the simulations' assumptions fair? |
| Prior art | `whitepaper/Zen_peg_prior_art_and_economics.md` | What is missing or misread? |
| Proof of Minting | white paper section "Proof of Minting"; `prototypes/jen0-go-devnet` | Incentives of minters, builders and miners; pool centralisation; the lottery. |
| Channels and factories | white paper section "Channels and channel factories"; `node/src/channel.rs`, `route.rs`; the demo scripts | Can a party lose money by following the protocol? Watchtower assumptions. |
| Physical coins | `L1-physical-coins` | Are the weights, fills and shapes makeable? How would you counterfeit one? |

### Testing and usability

Run the quick start on your machine (macOS on Apple Silicon has **not** been tested by the author), run the demos, try the Docker image, and report anything that does not match the README. A report that says "step 3 printed X instead of Y on machine Z" is useful.

## How to report

Open an issue with:

1. **Where:** file and function (or document and section).
2. **What:** the defect, in one or two sentences.
3. **Evidence:** a failing test, a command and its output, or the line of reasoning. A test that fails is the best report.
4. **Impact:** what an attacker or an unlucky user gets out of it.
5. **Version:** the commit hash you reviewed (`git rev-parse HEAD`).

Please say plainly how sure you are: *reproduced*, *read in the code but not run*, or *a suspicion*. All three are welcome when they are labelled.

There is nothing of value on the test network, so issues can be public. If you find something you believe should not be public yet, contact the author through the channels on the [project page](docs/index.html) before opening an issue.

## Ground rules for changes

- Consensus code, circuits and constants change only together with a test that shows the change is right.
- `reward_tables.rs` and `bn_consts.rs` are generated; change the generator, not the file.
- Run `cargo fmt` before a pull request (the CI checks it) and keep the function comments up to date.
- A circuit change invalidates the Groth16 key: say so in the pull request.
