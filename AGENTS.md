# Guide for AI assistants and agents

You were asked to test or review Zen. This file gives you the facts you need without reading the whole repository. Humans: [`REVIEWING.md`](REVIEWING.md) is the same map with more explanation.

## Facts

- **What it is:** a research prototype of a metal-backed monetary system: three physical coins and three proof-of-work chains (Yen = chain 1, Ken = 2, Jen = 3) whose blocks each carry one zero-knowledge validity proof. Test network only; coins have no value; no outside audit.
- **Main code:** `L2-cryptocurrencies/node` (Rust, crate `zenproof`, one binary, about 40,000 lines in `src/`, edition 2024).
- **Design text:** `whitepaper/sec1.tex` to `sec4.tex` (LaTeX source of the white paper; easier for you to read than the PDF). Glossary: `docs/GLOSSARY.md`.
- **Known problems:** `docs/KNOWN-ISSUES.md`. Read it before reporting anything.
- **History of design decisions:** `L2-cryptocurrencies/node/docs/BUILD-LOG.md` (long; search it, do not read it whole).

## Commands that work

Run these from `L2-cryptocurrencies/node`. All need `RUSTC_BOOTSTRAP=1` in the environment (plonky2 uses nightly features).

| Goal | Command | Time on 2 cores | Success looks like |
|---|---|---|---|
| Build | `RUSTC_BOOTSTRAP=1 cargo build --release` | 2 to 10 min | `Finished` and about 40 warnings |
| Format check | `cargo fmt --check` | seconds | no output |
| Fast tests | `RUSTC_BOOTSTRAP=1 cargo test --release seal::` (also `store::`, `transport::`, `reward::`, `groth16::`, `tx::`, `mempool::`) | seconds each after the test build | `test result: ok.` |
| All tests | `RUSTC_BOOTSTRAP=1 cargo test --release` | 25 to 35 min | `139 passed; 0 failed; 2 ignored` |
| Soundness tests only | `RUSTC_BOOTSTRAP=1 cargo test --release soundness::` | about 10 min | 4 tests ok |
| Make a test network | `target/release/zenproof net init all /tmp/zen-net` | 1 s | `wrote /tmp/zen-net (...)` |
| Run it | `target/release/zenproof node serve-all /tmp/zen-net` | runs until killed | listens on 18440-18442 (peers), 18450-18452 (Stratum), 18460-18462 (HTTP API) |
| Mine | `target/release/zenproof node mine 127.0.0.1:18452 3` | about 10 s | `RESULT miner: 3 blocks accepted` |
| Node status | `curl -s http://127.0.0.1:18462/api/status` | instant | JSON with `height` |
| A scripted scenario | `bash scripts/demo_market.sh` (others in `scripts/`) | 1 to 5 min | sections starting with `==` and no error |

Other parts: `python3 simulations/python/detect_sim.py` (2 s), `node simulations/js/tri2.js` (1 s); the rest are listed with times in `simulations/README.md`. Full list of checks: `docs/TESTING.md`.

## Things that will trip you

- **Do not run `zenproof` with no arguments.** It starts a proving benchmark that runs for minutes.
- **`cargo test` without `--release` is far too slow.** The tests build real proofs.
- **The demo scripts run `pkill -x zenproof`** and write under `/tmp`. Do not run two at once.
- **Long lines in comments are normal.** Code is formatted by rustfmt; comments are not wrapped.
- **`reward_tables.rs` and `bn_consts.rs` are generated** and marked `#[rustfmt::skip]`. Do not edit or reformat them.
- **`logs/` and `proof-artifacts/` are evidence, not code.** They are outputs of the author's earlier runs. Paths inside old logs refer to the author's machine.
- **Stand-in stamps.** The test network uses `DevStamp` (a hash) in place of the Groth16 proof. Real stamps need a 2 GB proving key that is not in the repository.
- **`SPEC x.y` in comments** refers to a specification that is not in the repository. Use the white paper.
- **Go prototypes** (`L2-cryptocurrencies/prototypes`) have no `go.mod`; building them needs module setup and network access.

## Where things are

| Topic | File (under `L2-cryptocurrencies/node/src/`) |
|---|---|
| Block validation, fork choice, snapshots | `node.rs` |
| Rules of every operation (the specification for the circuits) | `locks.rs`, function `Run::one` |
| Signatures, curve, custom gate | `ec.rs`, `mint.rs` |
| Payment circuits, merge, shrink, CLI entry | `main.rs` |
| Operation circuits | `opcirc.rs`, `chancirc.rs`, `ordercirc.rs`, `factorycirc.rs`, `commoncirc.rs` |
| Soundness tests | `soundness.rs` |
| Groth16 verifier | `groth16.rs` |
| Proof-of-work header, Stratum job | `seal.rs` |
| Peers and Stratum server | `p2p.rs` |
| Encrypted wire | `transport.rs` |
| HTTP API | `api.rs` |
| Wallet | `tx.rs`, `walletweb.rs` |
| Channels, routing, watchtower | `channel.rs`, `route.rs` |
| Storage | `store.rs` |

Tests live at the end of each file in `#[cfg(test)] mod tests`; test names are sentences. Comments marked `REVIEW:` point at places worth checking first (`grep -rn "REVIEW:" src/`).

## How to review well here

1. Say what you checked and what you did not. A review of `transport.rs` is not a review of Zen.
2. Separate three levels of confidence in every finding: **reproduced** (you ran it and saw it), **read** (you traced it in the code but did not run it), **suspected**.
3. Prefer a failing test to a paragraph. A new `#[test]` in the file's `mod tests` that fails is the strongest report. Run it with `cargo test --release <name>`.
4. The node's rules are the specification. For a circuit, the question is: can it prove something `locks.rs` refuses? `soundness.rs` shows how to build such attempts.
5. Check `docs/KNOWN-ISSUES.md` and `L2-cryptocurrencies/node/docs/SECURITY-REVIEW.md` before reporting; cite the item if yours is related.
6. Do not judge the economics from the code alone. The peg argument is in the white paper and the models in `simulations/`.
7. Never suggest that the test network or its keys are safe for real value. They are not: the Groth16 setup is single-party, and the keys of `node devnet` are derived from public constants.

## Report format

```
Where:      path/to/file.rs, function name (or document, section)
Confidence: reproduced | read | suspected
What:       one or two sentences
Evidence:   command and output, failing test, or the chain of reasoning with line references
Impact:     what an attacker or user gets out of it
Commit:     output of `git rev-parse HEAD`
```
