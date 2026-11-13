# Testing Zen: every check in one place

This page lists everything in the repository that can be run, with the command, how long it takes and what success looks like. Start at the top; each level takes more time than the one before.

**What was checked, and when.** The column "Checked" says whether the step was run during the repository clean-up on 13 November 2026, on Linux x86-64 with 2 cores and 7 GB of memory, Rust 1.97, Go 1.24, Python 3.13, Node 22. Times are from that machine and are only a guide. Steps marked "no" are documented from the author's notes and were not run then. Nothing has been checked on macOS or Windows.

The same commands are wrapped in the [`Makefile`](../Makefile): run `make help` at the repository root.

## Level 0: what you need

| Part | Needs |
|---|---|
| Node, benchmarks | Linux or macOS; [Rust](https://rustup.rs) stable 1.85 or newer; 2 GB of disk. The tests were run with 7 GB of memory; the minimum was not measured |
| Simulations | Python 3 with `numpy` (and `cryptography` for one script); Node.js 18 or newer |
| White paper | a TeX distribution with `pdflatex` |
| Real Groth16 stamps (optional) | Go 1.26.8 or newer, 6 GB of memory, 2 GB of disk |

All node commands below are run from `L2-cryptocurrencies/node` with `RUSTC_BOOTSTRAP=1` set (`export RUSTC_BOOTSTRAP=1`).

## Level 1: ten minutes

| # | Check | Command | Time | Success looks like | Checked |
|---|---|---|---|---|---|
| 1.1 | The node builds | `cargo build --release` | 2 to 10 min | `Finished`, about 40 warnings | yes |
| 1.2 | The code is formatted | `cargo fmt --check` | seconds | no output | yes |
| 1.3 | Fast tests | `cargo test --release -- seal:: store:: transport:: reward:: groth16:: tx:: mempool::` | 10 s after the test build (which takes a few minutes the first time) | `30 passed; 0 failed` | yes |
| 1.4 | Three chains start | `target/release/zenproof net init all /tmp/zen-net` then `target/release/zenproof node serve-all /tmp/zen-net` | seconds | `wrote /tmp/zen-net (...)`; the explorers answer on ports 18460 to 18462 | yes |
| 1.5 | Mining | `for p in 18450 18451 18452; do target/release/zenproof node mine 127.0.0.1:$p 3; done` | 30 s | `RESULT miner: 3 blocks accepted` three times | yes |
| 1.6 | A payment | the `wallet pay`, `node mine`, `wallet balance` lines of the [quick start](../README.md#quick-start) | 10 s | `balance 10001000000 base units` | yes |

## Level 2: one hour

| # | Check | Command | Time | Success looks like | Checked |
|---|---|---|---|---|---|
| 2.1 | The whole test suite | `cargo test --release` | 25 to 35 min | `139 passed; 0 failed; 2 ignored` | yes (log: `logs/run_tests_cleanup_2026-11-13.txt`) |
| 2.2 | Market: orders, official rate, batch auction | `bash scripts/demo_market.sh` | 2 min | three `==` sections; ends with `1 Yen = ... Ken` | yes |
| 2.3 | Channel: open and pay off chain | `bash scripts/demo_channels_1.sh` | 20 s | three `==` sections, no error | yes |
| 2.4 | Channel: close, and an old-state attempt (run after 2.3) | `bash scripts/demo_channels_2.sh` | 1 min | three `==` sections, no error | yes |
| 2.5 | Dual-funded channel | `bash scripts/demo_dual.sh` | 1 min | two `==` sections, no error | yes |
| 2.6 | Factory | `bash scripts/demo_factory.sh` | 1 min | five `==` sections, no error | yes |
| 2.7 | Routing across three chains | `bash scripts/demo_routing.sh` | 1 min | ends with each node's channel balances | yes |
| 2.8 | Watchtower | `bash scripts/demo_tower.sh` | 1 min | three `==` sections, no error | yes |
| 2.9 | Channel peers over the network | `bash scripts/demo_network.sh` | 30 s | five `==` sections, no error | yes |
| 2.10 | A node that closes a channel by itself | `bash scripts/demo_guard.sh` | 2 min | three `==` sections, no error | yes |
| 2.11 | Three chains as three processes | `bash scripts/demo_split.sh` | 1 min | two `==` sections, no error | yes |

The demo scripts need `curl` and `python3`. Each one stops any running `zenproof` and starts a fresh network under `/tmp`, so run them one at a time and not while your own test network is running. "No error" was checked by searching the output for `error`, `panic` and `usage:`; the scripts do not yet verify their own results, so read the output against the script's comments if you are reviewing behaviour.

## Level 3: the other parts

| # | Check | Where | Command | Time | Success looks like | Checked |
|---|---|---|---|---|---|---|
| 3.1 | Simulations | `simulations/` | see [`simulations/README.md`](../simulations/README.md) | 1 s to 6 min each | each prints a table | yes, 16 of 18 runnable models; `js/sim.js` and `js/q.js` need about 5 GB of memory and were not completed |
| 3.2 | White paper builds | `whitepaper/` | `pdflatex zen-whitepaper.tex` twice | 1 min | `zen-whitepaper.pdf`, 47 pages | yes |
| 3.3 | Stored Groth16 stamps verify | `L2-cryptocurrencies/node` | `cargo test --release groth16::` | seconds | `test result: ok` | yes (part of 1.3) |
| 3.4 | A benchmark crate | `L2-cryptocurrencies/benchmarks/p2sigopt` | `cargo build --release && ./target/release/p2sigopt 4 2` | 2 min build, 2 min run, about 1 GB of memory | `RESULT` lines ending with the shrink proofs | yes |
| 3.5 | The other five benchmark crates | `L2-cryptocurrencies/benchmarks/*` | `cargo build --release` in each | minutes each | builds | no (formatted only) |
| 3.6 | Data-minting prototype | `data-minting/` | `PYTHONINTMAXSTRDIGITS=0 MPLBACKEND=Agg python3 mint.py` | seconds | `deminted.mario.gif` identical to `mario.gif` | yes |
| 3.7 | Supply simulation (2020, Python 2) | `L2-cryptocurrencies/prototypes/supply-simulation/` | see its README | under a minute | three supply lines and three ratios | yes, converted to Python 3 |
| 3.8 | Go prototypes | `L2-cryptocurrencies/prototypes/` | see its README | | | no |

## Level 4: heavy or special hardware

| # | Check | Where | Notes | Checked |
|---|---|---|---|---|
| 4.1 | Real Groth16 stamps end to end | `L2-cryptocurrencies/groth16-wrap/` | needs Go 1.26.8+, a 2 GB proving key made by a 20-minute setup | no |
| 4.2 | Docker image, compose, Kubernetes | `L2-cryptocurrencies/node/docs/DOCKER.md` | the author's notes say the image was never built in the build environment | no |
| 4.3 | GPU prover benchmark | `L2-cryptocurrencies/groth16-wrap/bench_gpu.sh` | needs an NVIDIA GPU with CUDA and ICICLE | no |
| 4.4 | macOS (Apple Silicon) | `L2-cryptocurrencies/node/docs/RUN-LOCALLY.md` | written but never run on a Mac | no |
| 4.5 | GitHub Actions | `.github/workflows/` | `ci.yml` is new; `docker.yml` was moved to the root, where GitHub will run it for the first time | no |

If you run one of the unchecked steps, please report the result (working or not) in an issue: that alone is a useful contribution.

## When something fails

1. Check [`KNOWN-ISSUES.md`](KNOWN-ISSUES.md).
2. `error: ... #![feature] may not be used on the stable release channel`: `RUSTC_BOOTSTRAP=1` is not set.
3. `Address already in use`: another `zenproof` is running (`pkill -x zenproof`), or the ports 18440 to 18470 are taken.
4. A test or simulation killed without a message: probably out of memory. Close other programs, or run the heavy items one at a time.
5. Otherwise open an issue with the command, the full output, your operating system and `rustc --version`.
