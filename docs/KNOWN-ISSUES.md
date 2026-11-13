# Known issues and open questions

One list for the whole repository, so a reviewer does not spend time rediscovering what is already known. Items are grouped by how sure we are. If you find something that is not here, please open an issue (see [`../REVIEWING.md`](../REVIEWING.md)).

## A. Confirmed defects (reproduced, not yet fixed)

### 1. A malformed `mining.submit` crashes its Stratum connection thread and leaks a connection slot

- **Where:** `L2-cryptocurrencies/node/src/p2p.rs`, `Stratum::serve` (the `mining.submit` arm) calls `seal::unhex` on the miner's `extranonce2` text. `seal::unhex` (`src/seal.rs`) panics on a non-hex character or an odd length.
- **Effect:** the connection's thread panics. `Stratum::listen` decrements its `active` counter only after `serve` returns, so the slot is never given back. After `MAX_STRATUM_CONNS` (256) such submissions the Stratum port drops every new miner until the node restarts. No lock is held at the panic, so the rest of the node keeps running.
- **Reproduced:** 13 November 2026 on the three-chain test network: one submit with `extranonce2 = "zzzzzzzz"` closed the connection with a panic at `src/seal.rs`; after 256 of them a new, well-behaved miner was refused.
- **Who can do it:** anyone who can reach the Stratum port (loopback by default).
- **Suggested fix:** make `seal::unhex` return a `Result` (as `tx.rs` and `api.rs` already do) and decrement `active` in a guard that also runs on panic. Then check the other callers of `seal::unhex`.

## B. Known and stated by the author (design limits of the test network)

These are documented in [`../L2-cryptocurrencies/node/docs/SECURITY-REVIEW.md`](../L2-cryptocurrencies/node/docs/SECURITY-REVIEW.md) and [`PROOFS-PLAN.md`](../L2-cryptocurrencies/node/docs/PROOFS-PLAN.md). In short:

1. **The Groth16 proving key comes from a single-party setup.** Whoever ran it could forge stamps. A public multi-party ceremony for the exact circuit is required before any real use.
2. **The test network runs on stand-in stamps** (`DevStamp`), which prove nothing. Safety then rests on every node replaying every block.
3. **The foreign payment proof of an order claim is checked by every node, not inside the circuit.**
4. **Some rules are left to the node by design** and are not in the circuits: key subgroup membership, key/address binding, the sign of y, uniqueness of a new address, distinct factory members.
5. **The transport is a home-made construction** (SHA-256 key stream, truncated SHA-256 MAC, Schnorr-authenticated ephemeral Diffie-Hellman). No forward secrecy for requests; the replay cache is in memory.
6. **The official rate can be pushed** by a trader with several accounts; it is a hint, not an oracle.
7. **No fuzzing yet** of any decoder (blocks, operations, terms, frames, snapshots).
8. **No outside audit** of circuits, consensus or cryptography.
9. **The container image and Kubernetes files were never built or run** by the author's build environment (syntax-checked only).
10. **Wallet key files are stored unencrypted.**

## C. Open design questions (research, not bugs)

1. **The peg.** Whether one electronic coin holds the value of one physical coin with no custodian and no price feed is the central claim of the project. The evidence so far is the simulations in [`../simulations`](../simulations) and the argument in the white paper (sections "The coin weight" and "Three currencies, six coins"). It has not been tested with real users or reviewed by economists.
2. **Physical coins.** Checking a coin by hand and making coins hard to counterfeit are open research ([`../L1-physical-coins`](../L1-physical-coins)).
3. **Prover speed.** The stamp takes about 3.7 minutes on 2 CPU cores; Jen's block time is 2.5 minutes. GPU timings are not measured yet ([`../L2-cryptocurrencies/groth16-wrap/BUILDER-GPU.md`](../L2-cryptocurrencies/groth16-wrap/BUILDER-GPU.md)).
4. **Economic attacks** not yet analysed in code: selfish mining, fee sniping, eclipse of a node at start-up (the seed list is trusted).

## D. Gaps in this repository

1. **`whitepaper/figs.py` cannot run as shipped.** It reads `whitepaper/data/series.json` and `whitepaper/data/launch.json`, which were never committed. The finished figures are in `whitepaper/figs/`, so the PDF builds; only regenerating figures is blocked.
2. **The Zen Protocol Specification** that code comments cite as `SPEC x.y` is not in the repository.
3. **The Go prototypes have no `go.mod`** and were not rebuilt (see their READMEs).
4. **Not every function has a comment yet.** In the node, 350 previously uncommented functions were documented in the clean-up; 176 remain, mostly in `route.rs` (40), `main.rs` (30), `prover.rs` (19), `channel.rs` (18), `api.rs` (17) and `soundness.rs` (15).
5. **Layer numbers differ between the repository and the white paper.** The repository counts physical coins as layer 1, the chains as layer 2 and channels as layer 3. The white paper's section titles call channels "L2" and Zen Net "L3". One of the two should change.
6. **Continuous integration is new and unproven.** `.github/workflows/ci.yml` was written for this layout but has not run on GitHub yet.

## E. Things worth a reviewer's time (unverified leads)

Places marked `REVIEW:` in the code. None is a known bug.

- `ec.rs`: the in-circuit gate (`eval_unfiltered_circuit`) must equal the native constraint function (`constraints`) term for term.
- `opcirc.rs`, `chancirc.rs`, `ordercirc.rs`, `factorycirc.rs`, `main.rs`: 28 uses of `BoolTarget::new_unsafe`. Each needs an argument that the value is already constrained to 0 or 1.
- `groth16.rs`: `Reader::take` adds a length read from the key file without an overflow check (the key file is local and trusted today).
- `transport.rs`: MACs are compared with `!=`, not in constant time.
- `seal.rs`: `body_root` hashes the stamp without a length prefix (the length is fixed elsewhere).
- `node.rs`, `locks.rs`, `p2p.rs`: the decoders named as fuzzing targets.
