> This was the short index of the old `zen-rust/` folder. It is kept for the record; the current entry point is [`../README.md`](../README.md). Paths below were updated to the current layout.

# Zen reference node (Rust) and proof pipeline

`node/` (the `zenproof` crate) is the node, wallet, three-chain test network and proof pipeline. Start with `docs/RUN-LOCALLY.md` (build and run on a Mac, Linux works the same) and `docs/BUILD-LOG.md` (every build round, in order). `docs/PROOFS-PLAN.md` and `docs/SECURITY-REVIEW.md` list what is proved and what is open. Tests: `cd node && RUSTC_BOOTSTRAP=1 cargo test --release` (137 pass). `groth16-wrap/` is the Groth16 prover in Go; `p2`, `p2sig`, `p2sigopt`, `g16`, `g16sig` and `nova` (now in `../benchmarks/`) are earlier benchmarks.

Test network only: the coins have no value, the code is not audited, and the proof key (`proof-artifacts/out_v7/zen.vk`) comes from a single-party setup that must be replaced by a public ceremony before any real use. Large generated keys and build folders are not in the repository.
