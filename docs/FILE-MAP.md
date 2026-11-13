# File map: old repository to new layout

Every file of the old repository (`YoshiTakeshi/Zen` at the commit "Add Apache 2.0 license", 359 files) is in the new layout. Nothing was dropped. The first commit of this repository is that copy, byte for byte, so `git log --follow` and `git diff` show exactly what the clean-up changed afterwards.

## Folders

| Old | New |
|---|---|
| `L1 - Physical Coins/` | `L1-physical-coins/` (images in `images/`, 3D models in `models/`) |
| `L2 - Cryptocurrencies/zen-rust/zenproof/` | `L2-cryptocurrencies/node/` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/README.md` (the build rounds) | `L2-cryptocurrencies/node/docs/BUILD-LOG.md` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/MAC-TEST.md` | `L2-cryptocurrencies/node/docs/RUN-LOCALLY.md` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_*.txt` | `L2-cryptocurrencies/node/logs/` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v3` ... `out_v7` | `L2-cryptocurrencies/node/proof-artifacts/` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/` | `L2-cryptocurrencies/groth16-wrap/` |
| `L2 - Cryptocurrencies/zen-rust/{p2,p2sig,p2sigopt,g16,g16sig,nova}/` | `L2-cryptocurrencies/benchmarks/` |
| `L2 - Cryptocurrencies/zen-rust/README.md` (the benchmark report) | `L2-cryptocurrencies/benchmarks/README.md` |
| `L2 - Cryptocurrencies/zen-rust/BLOCKS.md` | `L2-cryptocurrencies/node/docs/BLOCKS.md` |
| `L2 - Cryptocurrencies/jen0-go-devnet/`, `pom-leaf-go/` | `L2-cryptocurrencies/prototypes/` |
| `L2 - Cryptocurrencies/Simulate_Supply.py` | `L2-cryptocurrencies/prototypes/supply-simulation/` |
| `L3 - Channel Factories/` | `L3-channel-factories/` |
| `Data Minting/` | `data-minting/` |
| `simulations/`, `whitepaper/`, `docs/`, `img/` | unchanged |
| `L2 - Cryptocurrencies/zen-rust/.github/workflows/docker.yml` | `.github/workflows/docker.yml` (at the root, where GitHub runs it) |

## What the clean-up changed in file contents

1. **Paths.** Tests, scripts and documents that pointed at the old folder names or at the original build machine (`/home/claude/...`) now use the new names or their own location.
2. **Formatting.** All Rust code was formatted with `cargo fmt` (default settings). The two generated tables, `bn_consts.rs` and `reward_tables.rs`, were left byte-identical and marked `#[rustfmt::skip]`.
3. **Comments.** Doc comments were added to 350 functions of the node, and one misplaced doc comment in `locks.rs` was moved to the variant it describes. No code line changed in that step.
4. **Three scripts write next to themselves** instead of into a folder outside the repository: `simulations/python/detect_sim.py`, `detect9.py` (now `results/`) and `whitepaper/figs.py`.
5. **New documents:** the READMEs of every folder, `REVIEWING.md`, `AGENTS.md`, `docs/TESTING.md`, `docs/GLOSSARY.md`, `docs/KNOWN-ISSUES.md`, this file, a `Makefile` and a CI workflow.

The original text of every older README is kept below a line in its new README, or under a new name as listed above.

## Every file

| Old path | New path |
|---|---|
| `L2 - Cryptocurrencies/zen-rust/.github/workflows/docker.yml` | `.github/workflows/docker.yml` |
| `.gitignore` | `.gitignore` |
| `L1 - Physical Coins/README.MD` | `L1-physical-coins/README.md` |
| `L1 - Physical Coins/Specs.md` | `L1-physical-coins/SPECS.md` |
| `L1 - Physical Coins/3D-Coins-Model.png` | `L1-physical-coins/images/all-coins-model.png` |
| `L1 - Physical Coins/God's-Blocks-All.png` | `L1-physical-coins/images/gods-blocks-all.png` |
| `L1 - Physical Coins/God's-Blocks.png` | `L1-physical-coins/images/gods-blocks.png` |
| `L1 - Physical Coins/3D-Overview.png` | `L1-physical-coins/images/overview.png` |
| `L1 - Physical Coins/Ren/Ren_3D_Model.jpg` | `L1-physical-coins/images/ren-3d-model.jpg` |
| `L1 - Physical Coins/Sen/Sen_3D_Model.png` | `L1-physical-coins/images/sen-3d-model.png` |
| `L1 - Physical Coins/Ten/Ten_3D_Model.jpg` | `L1-physical-coins/images/ten-3d-model.jpg` |
| `L1 - Physical Coins/Ten/Ten_Double_Coin.jpg` | `L1-physical-coins/images/ten-double-coin.jpg` |
| `L1 - Physical Coins/3D Models.iges` | `L1-physical-coins/models/all-coins.iges` |
| `L1 - Physical Coins/3D Models Coins.stl` | `L1-physical-coins/models/all-coins.stl` |
| `L1 - Physical Coins/Ren Yellow Coins.zip` | `L1-physical-coins/models/ren-coins.zip` |
| `L1 - Physical Coins/Sen Red Coins.zip` | `L1-physical-coins/models/sen-coins.zip` |
| `L1 - Physical Coins/Ten/1 Ten.stl` | `L1-physical-coins/models/ten-1.stl` |
| `L1 - Physical Coins/Ten Blue Coins.zip` | `L1-physical-coins/models/ten-coins.zip` |
| `L2 - Cryptocurrencies/README.MD` | `L2-cryptocurrencies/README.md` |
| `L2 - Cryptocurrencies/zen-rust/README.md` | `L2-cryptocurrencies/benchmarks/README.md` |
| `L2 - Cryptocurrencies/zen-rust/g16/.gitignore` | `L2-cryptocurrencies/benchmarks/g16/.gitignore` |
| `L2 - Cryptocurrencies/zen-rust/g16/Cargo.lock` | `L2-cryptocurrencies/benchmarks/g16/Cargo.lock` |
| `L2 - Cryptocurrencies/zen-rust/g16/Cargo.toml` | `L2-cryptocurrencies/benchmarks/g16/Cargo.toml` |
| `L2 - Cryptocurrencies/zen-rust/g16/run_16x8.txt` | `L2-cryptocurrencies/benchmarks/g16/run_16x8.txt` |
| `L2 - Cryptocurrencies/zen-rust/g16/src/main.rs` | `L2-cryptocurrencies/benchmarks/g16/src/main.rs` |
| `L2 - Cryptocurrencies/zen-rust/g16sig/.gitignore` | `L2-cryptocurrencies/benchmarks/g16sig/.gitignore` |
| `L2 - Cryptocurrencies/zen-rust/g16sig/Cargo.lock` | `L2-cryptocurrencies/benchmarks/g16sig/Cargo.lock` |
| `L2 - Cryptocurrencies/zen-rust/g16sig/Cargo.toml` | `L2-cryptocurrencies/benchmarks/g16sig/Cargo.toml` |
| `L2 - Cryptocurrencies/zen-rust/g16sig/run_16x8_sig.txt` | `L2-cryptocurrencies/benchmarks/g16sig/run_16x8_sig.txt` |
| `L2 - Cryptocurrencies/zen-rust/g16sig/src/jj.rs` | `L2-cryptocurrencies/benchmarks/g16sig/src/jj.rs` |
| `L2 - Cryptocurrencies/zen-rust/g16sig/src/main.rs` | `L2-cryptocurrencies/benchmarks/g16sig/src/main.rs` |
| `L2 - Cryptocurrencies/zen-rust/nova/.gitignore` | `L2-cryptocurrencies/benchmarks/nova/.gitignore` |
| `L2 - Cryptocurrencies/zen-rust/nova/Cargo.lock` | `L2-cryptocurrencies/benchmarks/nova/Cargo.lock` |
| `L2 - Cryptocurrencies/zen-rust/nova/Cargo.toml` | `L2-cryptocurrencies/benchmarks/nova/Cargo.toml` |
| `L2 - Cryptocurrencies/zen-rust/nova/run_16x8.txt` | `L2-cryptocurrencies/benchmarks/nova/run_16x8.txt` |
| `L2 - Cryptocurrencies/zen-rust/nova/run_16x8_pasta.txt` | `L2-cryptocurrencies/benchmarks/nova/run_16x8_pasta.txt` |
| `L2 - Cryptocurrencies/zen-rust/nova/src/main.rs` | `L2-cryptocurrencies/benchmarks/nova/src/main.rs` |
| `L2 - Cryptocurrencies/zen-rust/p2/.gitignore` | `L2-cryptocurrencies/benchmarks/p2/.gitignore` |
| `L2 - Cryptocurrencies/zen-rust/p2/Cargo.lock` | `L2-cryptocurrencies/benchmarks/p2/Cargo.lock` |
| `L2 - Cryptocurrencies/zen-rust/p2/Cargo.toml` | `L2-cryptocurrencies/benchmarks/p2/Cargo.toml` |
| `L2 - Cryptocurrencies/zen-rust/p2/run_16x8.txt` | `L2-cryptocurrencies/benchmarks/p2/run_16x8.txt` |
| `L2 - Cryptocurrencies/zen-rust/p2/run_4x16.txt` | `L2-cryptocurrencies/benchmarks/p2/run_4x16.txt` |
| `L2 - Cryptocurrencies/zen-rust/p2/run_64x4.txt` | `L2-cryptocurrencies/benchmarks/p2/run_64x4.txt` |
| `L2 - Cryptocurrencies/zen-rust/p2/src/main.rs` | `L2-cryptocurrencies/benchmarks/p2/src/main.rs` |
| `L2 - Cryptocurrencies/zen-rust/p2/time_16x8.txt` | `L2-cryptocurrencies/benchmarks/p2/time_16x8.txt` |
| `L2 - Cryptocurrencies/zen-rust/p2sig/.gitignore` | `L2-cryptocurrencies/benchmarks/p2sig/.gitignore` |
| `L2 - Cryptocurrencies/zen-rust/p2sig/Cargo.lock` | `L2-cryptocurrencies/benchmarks/p2sig/Cargo.lock` |
| `L2 - Cryptocurrencies/zen-rust/p2sig/Cargo.toml` | `L2-cryptocurrencies/benchmarks/p2sig/Cargo.toml` |
| `L2 - Cryptocurrencies/zen-rust/p2sig/run_16x8_sig.txt` | `L2-cryptocurrencies/benchmarks/p2sig/run_16x8_sig.txt` |
| `L2 - Cryptocurrencies/zen-rust/p2sig/run_4x16_sig.txt` | `L2-cryptocurrencies/benchmarks/p2sig/run_4x16_sig.txt` |
| `L2 - Cryptocurrencies/zen-rust/p2sig/src/ec.rs` | `L2-cryptocurrencies/benchmarks/p2sig/src/ec.rs` |
| `L2 - Cryptocurrencies/zen-rust/p2sig/src/main.rs` | `L2-cryptocurrencies/benchmarks/p2sig/src/main.rs` |
| `L2 - Cryptocurrencies/zen-rust/p2sig/time_16x8.txt` | `L2-cryptocurrencies/benchmarks/p2sig/time_16x8.txt` |
| `L2 - Cryptocurrencies/zen-rust/p2sigopt/Cargo.lock` | `L2-cryptocurrencies/benchmarks/p2sigopt/Cargo.lock` |
| `L2 - Cryptocurrencies/zen-rust/p2sigopt/Cargo.toml` | `L2-cryptocurrencies/benchmarks/p2sigopt/Cargo.toml` |
| `L2 - Cryptocurrencies/zen-rust/p2sigopt/run_16x8_opt.txt` | `L2-cryptocurrencies/benchmarks/p2sigopt/run_16x8_opt.txt` |
| `L2 - Cryptocurrencies/zen-rust/p2sigopt/run_4x16_opt.txt` | `L2-cryptocurrencies/benchmarks/p2sigopt/run_4x16_opt.txt` |
| `L2 - Cryptocurrencies/zen-rust/p2sigopt/run_64x4_opt.txt` | `L2-cryptocurrencies/benchmarks/p2sigopt/run_64x4_opt.txt` |
| `L2 - Cryptocurrencies/zen-rust/p2sigopt/run_shrink.txt` | `L2-cryptocurrencies/benchmarks/p2sigopt/run_shrink.txt` |
| `L2 - Cryptocurrencies/zen-rust/p2sigopt/src/blockdata.rs` | `L2-cryptocurrencies/benchmarks/p2sigopt/src/blockdata.rs` |
| `L2 - Cryptocurrencies/zen-rust/p2sigopt/src/bn.rs` | `L2-cryptocurrencies/benchmarks/p2sigopt/src/bn.rs` |
| `L2 - Cryptocurrencies/zen-rust/p2sigopt/src/bn_consts.rs` | `L2-cryptocurrencies/benchmarks/p2sigopt/src/bn_consts.rs` |
| `L2 - Cryptocurrencies/zen-rust/p2sigopt/src/ec.rs` | `L2-cryptocurrencies/benchmarks/p2sigopt/src/ec.rs` |
| `L2 - Cryptocurrencies/zen-rust/p2sigopt/src/main.rs` | `L2-cryptocurrencies/benchmarks/p2sigopt/src/main.rs` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/BUILDER-GPU.md` | `L2-cryptocurrencies/groth16-wrap/BUILDER-GPU.md` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/README.md` | `L2-cryptocurrencies/groth16-wrap/README.md` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/bench_gpu.sh` | `L2-cryptocurrencies/groth16-wrap/bench_gpu.sh` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/gnark-plonky2-verifier-zen.patch` | `L2-cryptocurrencies/groth16-wrap/gnark-plonky2-verifier-zen.patch` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result/blockA/Verifier.sol` | `L2-cryptocurrencies/groth16-wrap/result/blockA/Verifier.sol` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result/blockA/block.bin` | `L2-cryptocurrencies/groth16-wrap/result/blockA/block.bin` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result/blockA/common_circuit_data.json` | `L2-cryptocurrencies/groth16-wrap/result/blockA/common_circuit_data.json` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result/blockA/proof_with_public_inputs.json` | `L2-cryptocurrencies/groth16-wrap/result/blockA/proof_with_public_inputs.json` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result/blockA/verifier_only_circuit_data.json` | `L2-cryptocurrencies/groth16-wrap/result/blockA/verifier_only_circuit_data.json` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result/blockA/zen.proof` | `L2-cryptocurrencies/groth16-wrap/result/blockA/zen.proof` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result/blockA/zen.pub` | `L2-cryptocurrencies/groth16-wrap/result/blockA/zen.pub` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result/blockA/zen.vk` | `L2-cryptocurrencies/groth16-wrap/result/blockA/zen.vk` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result/blockB/block.bin` | `L2-cryptocurrencies/groth16-wrap/result/blockB/block.bin` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result/blockB/proof_with_public_inputs.json` | `L2-cryptocurrencies/groth16-wrap/result/blockB/proof_with_public_inputs.json` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result/blockB/zen.proof` | `L2-cryptocurrencies/groth16-wrap/result/blockB/zen.proof` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result/blockB/zen.pub` | `L2-cryptocurrencies/groth16-wrap/result/blockB/zen.pub` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result/groth16_run.txt` | `L2-cryptocurrencies/groth16-wrap/result/groth16_run.txt` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result/plonky2_blocks.txt` | `L2-cryptocurrencies/groth16-wrap/result/plonky2_blocks.txt` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v2/Verifier.sol` | `L2-cryptocurrencies/groth16-wrap/result_v2/Verifier.sol` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v2/common_circuit_data.json` | `L2-cryptocurrencies/groth16-wrap/result_v2/common_circuit_data.json` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v2/groth16_run.txt` | `L2-cryptocurrencies/groth16-wrap/result_v2/groth16_run.txt` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v2/plonky2_blocks.txt` | `L2-cryptocurrencies/groth16-wrap/result_v2/plonky2_blocks.txt` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v2/v2A/block.bin` | `L2-cryptocurrencies/groth16-wrap/result_v2/v2A/block.bin` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v2/v2A/proof_with_public_inputs.json` | `L2-cryptocurrencies/groth16-wrap/result_v2/v2A/proof_with_public_inputs.json` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v2/v2A/zen.proof` | `L2-cryptocurrencies/groth16-wrap/result_v2/v2A/zen.proof` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v2/v2A/zen.pub` | `L2-cryptocurrencies/groth16-wrap/result_v2/v2A/zen.pub` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v2/v2B/block.bin` | `L2-cryptocurrencies/groth16-wrap/result_v2/v2B/block.bin` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v2/v2B/proof_with_public_inputs.json` | `L2-cryptocurrencies/groth16-wrap/result_v2/v2B/proof_with_public_inputs.json` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v2/v2B/zen.proof` | `L2-cryptocurrencies/groth16-wrap/result_v2/v2B/zen.proof` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v2/v2B/zen.pub` | `L2-cryptocurrencies/groth16-wrap/result_v2/v2B/zen.pub` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v2/v2C/block.bin` | `L2-cryptocurrencies/groth16-wrap/result_v2/v2C/block.bin` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v2/v2C/proof_with_public_inputs.json` | `L2-cryptocurrencies/groth16-wrap/result_v2/v2C/proof_with_public_inputs.json` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v2/v2C/zen.proof` | `L2-cryptocurrencies/groth16-wrap/result_v2/v2C/zen.proof` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v2/v2C/zen.pub` | `L2-cryptocurrencies/groth16-wrap/result_v2/v2C/zen.pub` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v2/verifier_only_circuit_data.json` | `L2-cryptocurrencies/groth16-wrap/result_v2/verifier_only_circuit_data.json` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v2/zen.vk` | `L2-cryptocurrencies/groth16-wrap/result_v2/zen.vk` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v4/Verifier.sol` | `L2-cryptocurrencies/groth16-wrap/result_v4/Verifier.sol` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v4/accel_cpu_attempt.log` | `L2-cryptocurrencies/groth16-wrap/result_v4/accel_cpu_attempt.log` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v4/v4.log` | `L2-cryptocurrencies/groth16-wrap/result_v4/v4.log` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v4/zen.proof` | `L2-cryptocurrencies/groth16-wrap/result_v4/zen.proof` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v4/zen.vk` | `L2-cryptocurrencies/groth16-wrap/result_v4/zen.vk` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v6/block.bin` | `L2-cryptocurrencies/groth16-wrap/result_v6/block.bin` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v6/proof_with_public_inputs.json` | `L2-cryptocurrencies/groth16-wrap/result_v6/proof_with_public_inputs.json` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v6/zen.proof` | `L2-cryptocurrencies/groth16-wrap/result_v6/zen.proof` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v6/zen.pub` | `L2-cryptocurrencies/groth16-wrap/result_v6/zen.pub` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/result_v6/zen.vk` | `L2-cryptocurrencies/groth16-wrap/result_v6/zen.vk` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/tools/fill.sh` | `L2-cryptocurrencies/groth16-wrap/tools/fill.sh` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/tools/goproxy.py` | `L2-cryptocurrencies/groth16-wrap/tools/goproxy.py` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/zenwrap/accel_icicle.go` | `L2-cryptocurrencies/groth16-wrap/zenwrap/accel_icicle.go` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/zenwrap/accel_none.go` | `L2-cryptocurrencies/groth16-wrap/zenwrap/accel_none.go` |
| `L2 - Cryptocurrencies/zen-rust/g16wrap/zenwrap/main.go` | `L2-cryptocurrencies/groth16-wrap/zenwrap/main.go` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/.cargo/config.toml` | `L2-cryptocurrencies/node/.cargo/config.toml` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/.dockerignore` | `L2-cryptocurrencies/node/.dockerignore` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/Cargo.lock` | `L2-cryptocurrencies/node/Cargo.lock` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/Cargo.toml` | `L2-cryptocurrencies/node/Cargo.toml` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/Dockerfile` | `L2-cryptocurrencies/node/Dockerfile` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/docker-compose.split.yml` | `L2-cryptocurrencies/node/docker-compose.split.yml` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/docker-compose.yml` | `L2-cryptocurrencies/node/docker-compose.yml` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/docker/entrypoint.sh` | `L2-cryptocurrencies/node/docker/entrypoint.sh` |
| `L2 - Cryptocurrencies/zen-rust/BLOCKS.md` | `L2-cryptocurrencies/node/docs/BLOCKS.md` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/README.md` | `L2-cryptocurrencies/node/docs/BUILD-LOG.md` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/DOCKER.md` | `L2-cryptocurrencies/node/docs/DOCKER.md` |
| `L2 - Cryptocurrencies/zen-rust/README-ZEN-RUST.md` | `L2-cryptocurrencies/node/docs/OLD-INDEX.md` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/PROOFS-PLAN.md` | `L2-cryptocurrencies/node/docs/PROOFS-PLAN.md` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/MAC-TEST.md` | `L2-cryptocurrencies/node/docs/RUN-LOCALLY.md` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/SECURITY-REVIEW.md` | `L2-cryptocurrencies/node/docs/SECURITY-REVIEW.md` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/k8s/zen.yaml` | `L2-cryptocurrencies/node/k8s/zen.yaml` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_export_v6.txt` | `L2-cryptocurrencies/node/logs/run_export_v6.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_export_v7.txt` | `L2-cryptocurrencies/node/logs/run_export_v7.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_g16_compile_v6.txt` | `L2-cryptocurrencies/node/logs/run_g16_compile_v6.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_g16_node.txt` | `L2-cryptocurrencies/node/logs/run_g16_node.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_g16_node_persistent.txt` | `L2-cryptocurrencies/node/logs/run_g16_node_persistent.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_g16_node_round30.txt` | `L2-cryptocurrencies/node/logs/run_g16_node_round30.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_g16_node_v7.txt` | `L2-cryptocurrencies/node/logs/run_g16_node_v7.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_g16_ops_v7.txt` | `L2-cryptocurrencies/node/logs/run_g16_ops_v7.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_g16_setup_v6.txt` | `L2-cryptocurrencies/node/logs/run_g16_setup_v6.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_g16_setup_v7.txt` | `L2-cryptocurrencies/node/logs/run_g16_setup_v7.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_g16_setup_v7b.txt` | `L2-cryptocurrencies/node/logs/run_g16_setup_v7b.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_groth16.txt` | `L2-cryptocurrencies/node/logs/run_groth16.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_mint.txt` | `L2-cryptocurrencies/node/logs/run_mint.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_node_devnet.txt` | `L2-cryptocurrencies/node/logs/run_node_devnet.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_node_net.txt` | `L2-cryptocurrencies/node/logs/run_node_net.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_node_real.txt` | `L2-cryptocurrencies/node/logs/run_node_real.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_payouts.txt` | `L2-cryptocurrencies/node/logs/run_payouts.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_reading.txt` | `L2-cryptocurrencies/node/logs/run_reading.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_seal.txt` | `L2-cryptocurrencies/node/logs/run_seal.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round17.txt` | `L2-cryptocurrencies/node/logs/run_tests_round17.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round18.txt` | `L2-cryptocurrencies/node/logs/run_tests_round18.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round23.txt` | `L2-cryptocurrencies/node/logs/run_tests_round23.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round24.txt` | `L2-cryptocurrencies/node/logs/run_tests_round24.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round25.txt` | `L2-cryptocurrencies/node/logs/run_tests_round25.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round26.txt` | `L2-cryptocurrencies/node/logs/run_tests_round26.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round27.txt` | `L2-cryptocurrencies/node/logs/run_tests_round27.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round28.txt` | `L2-cryptocurrencies/node/logs/run_tests_round28.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round29.txt` | `L2-cryptocurrencies/node/logs/run_tests_round29.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round30.txt` | `L2-cryptocurrencies/node/logs/run_tests_round30.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round31.txt` | `L2-cryptocurrencies/node/logs/run_tests_round31.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round32.txt` | `L2-cryptocurrencies/node/logs/run_tests_round32.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round33.txt` | `L2-cryptocurrencies/node/logs/run_tests_round33.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round34.txt` | `L2-cryptocurrencies/node/logs/run_tests_round34.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round35.txt` | `L2-cryptocurrencies/node/logs/run_tests_round35.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round37.txt` | `L2-cryptocurrencies/node/logs/run_tests_round37.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round38.txt` | `L2-cryptocurrencies/node/logs/run_tests_round38.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round39.txt` | `L2-cryptocurrencies/node/logs/run_tests_round39.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round40.txt` | `L2-cryptocurrencies/node/logs/run_tests_round40.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round42.txt` | `L2-cryptocurrencies/node/logs/run_tests_round42.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round43.txt` | `L2-cryptocurrencies/node/logs/run_tests_round43.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round44.txt` | `L2-cryptocurrencies/node/logs/run_tests_round44.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round45.txt` | `L2-cryptocurrencies/node/logs/run_tests_round45.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round46.txt` | `L2-cryptocurrencies/node/logs/run_tests_round46.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round47.txt` | `L2-cryptocurrencies/node/logs/run_tests_round47.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round48.txt` | `L2-cryptocurrencies/node/logs/run_tests_round48.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round49.txt` | `L2-cryptocurrencies/node/logs/run_tests_round49.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round50.txt` | `L2-cryptocurrencies/node/logs/run_tests_round50.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round51.txt` | `L2-cryptocurrencies/node/logs/run_tests_round51.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round52.txt` | `L2-cryptocurrencies/node/logs/run_tests_round52.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round53.txt` | `L2-cryptocurrencies/node/logs/run_tests_round53.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round54.txt` | `L2-cryptocurrencies/node/logs/run_tests_round54.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_tests_round55.txt` | `L2-cryptocurrencies/node/logs/run_tests_round55.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_v3_16x8.txt` | `L2-cryptocurrencies/node/logs/run_v3_16x8.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_v4_16x8.txt` | `L2-cryptocurrencies/node/logs/run_v4_16x8.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_v5_peg_16x8.txt` | `L2-cryptocurrencies/node/logs/run_v5_peg_16x8.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/run_wallet.txt` | `L2-cryptocurrencies/node/logs/run_wallet.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v3/block.bin` | `L2-cryptocurrencies/node/proof-artifacts/out_v3/block.bin` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v3/common_circuit_data.json` | `L2-cryptocurrencies/node/proof-artifacts/out_v3/common_circuit_data.json` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v3/proof_with_public_inputs.json` | `L2-cryptocurrencies/node/proof-artifacts/out_v3/proof_with_public_inputs.json` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v3/verifier_only_circuit_data.json` | `L2-cryptocurrencies/node/proof-artifacts/out_v3/verifier_only_circuit_data.json` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v4/block.bin` | `L2-cryptocurrencies/node/proof-artifacts/out_v4/block.bin` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v4/common_circuit_data.json` | `L2-cryptocurrencies/node/proof-artifacts/out_v4/common_circuit_data.json` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v4/proof_with_public_inputs.json` | `L2-cryptocurrencies/node/proof-artifacts/out_v4/proof_with_public_inputs.json` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v4/verifier_only_circuit_data.json` | `L2-cryptocurrencies/node/proof-artifacts/out_v4/verifier_only_circuit_data.json` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v5/block.bin` | `L2-cryptocurrencies/node/proof-artifacts/out_v5/block.bin` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v5/common_circuit_data.json` | `L2-cryptocurrencies/node/proof-artifacts/out_v5/common_circuit_data.json` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v5/proof_with_public_inputs.json` | `L2-cryptocurrencies/node/proof-artifacts/out_v5/proof_with_public_inputs.json` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v5/verifier_only_circuit_data.json` | `L2-cryptocurrencies/node/proof-artifacts/out_v5/verifier_only_circuit_data.json` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v6/block.bin` | `L2-cryptocurrencies/node/proof-artifacts/out_v6/block.bin` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v6/common_circuit_data.json` | `L2-cryptocurrencies/node/proof-artifacts/out_v6/common_circuit_data.json` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v6/proof_with_public_inputs.json` | `L2-cryptocurrencies/node/proof-artifacts/out_v6/proof_with_public_inputs.json` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v6/verifier_only_circuit_data.json` | `L2-cryptocurrencies/node/proof-artifacts/out_v6/verifier_only_circuit_data.json` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v7/Verifier.sol` | `L2-cryptocurrencies/node/proof-artifacts/out_v7/Verifier.sol` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v7/block.bin` | `L2-cryptocurrencies/node/proof-artifacts/out_v7/block.bin` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v7/common_circuit_data.json` | `L2-cryptocurrencies/node/proof-artifacts/out_v7/common_circuit_data.json` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v7/proof_with_public_inputs.json` | `L2-cryptocurrencies/node/proof-artifacts/out_v7/proof_with_public_inputs.json` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v7/verifier_only_circuit_data.json` | `L2-cryptocurrencies/node/proof-artifacts/out_v7/verifier_only_circuit_data.json` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/out_v7/zen.vk` | `L2-cryptocurrencies/node/proof-artifacts/out_v7/zen.vk` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/scripts/com.zen.node.plist` | `L2-cryptocurrencies/node/scripts/com.zen.node.plist` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/scripts/demo_channels_1.sh` | `L2-cryptocurrencies/node/scripts/demo_channels_1.sh` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/scripts/demo_channels_2.sh` | `L2-cryptocurrencies/node/scripts/demo_channels_2.sh` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/scripts/demo_dual.sh` | `L2-cryptocurrencies/node/scripts/demo_dual.sh` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/scripts/demo_factory.sh` | `L2-cryptocurrencies/node/scripts/demo_factory.sh` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/scripts/demo_guard.sh` | `L2-cryptocurrencies/node/scripts/demo_guard.sh` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/scripts/demo_market.sh` | `L2-cryptocurrencies/node/scripts/demo_market.sh` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/scripts/demo_network.sh` | `L2-cryptocurrencies/node/scripts/demo_network.sh` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/scripts/demo_routing.sh` | `L2-cryptocurrencies/node/scripts/demo_routing.sh` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/scripts/demo_split.sh` | `L2-cryptocurrencies/node/scripts/demo_split.sh` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/scripts/demo_tower.sh` | `L2-cryptocurrencies/node/scripts/demo_tower.sh` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/scripts/run-forever.sh` | `L2-cryptocurrencies/node/scripts/run-forever.sh` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/api.rs` | `L2-cryptocurrencies/node/src/api.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/blockdata.rs` | `L2-cryptocurrencies/node/src/blockdata.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/bn.rs` | `L2-cryptocurrencies/node/src/bn.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/bn_consts.rs` | `L2-cryptocurrencies/node/src/bn_consts.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/chancirc.rs` | `L2-cryptocurrencies/node/src/chancirc.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/channel.rs` | `L2-cryptocurrencies/node/src/channel.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/commoncirc.rs` | `L2-cryptocurrencies/node/src/commoncirc.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/crosschain.rs` | `L2-cryptocurrencies/node/src/crosschain.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/ec.rs` | `L2-cryptocurrencies/node/src/ec.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/factorycirc.rs` | `L2-cryptocurrencies/node/src/factorycirc.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/groth16.rs` | `L2-cryptocurrencies/node/src/groth16.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/locks.rs` | `L2-cryptocurrencies/node/src/locks.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/main.rs` | `L2-cryptocurrencies/node/src/main.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/market.rs` | `L2-cryptocurrencies/node/src/market.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/mempool.rs` | `L2-cryptocurrencies/node/src/mempool.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/mint.rs` | `L2-cryptocurrencies/node/src/mint.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/netconf.rs` | `L2-cryptocurrencies/node/src/netconf.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/node.rs` | `L2-cryptocurrencies/node/src/node.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/opcirc.rs` | `L2-cryptocurrencies/node/src/opcirc.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/ordercirc.rs` | `L2-cryptocurrencies/node/src/ordercirc.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/p2p.rs` | `L2-cryptocurrencies/node/src/p2p.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/phi_inv_q32.bin` | `L2-cryptocurrencies/node/src/phi_inv_q32.bin` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/phi_inv_q32.sha256` | `L2-cryptocurrencies/node/src/phi_inv_q32.sha256` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/prover.rs` | `L2-cryptocurrencies/node/src/prover.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/reading.rs` | `L2-cryptocurrencies/node/src/reading.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/reward.rs` | `L2-cryptocurrencies/node/src/reward.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/reward_reference_jen.txt` | `L2-cryptocurrencies/node/src/reward_reference_jen.txt` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/reward_tables.rs` | `L2-cryptocurrencies/node/src/reward_tables.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/route.rs` | `L2-cryptocurrencies/node/src/route.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/seal.rs` | `L2-cryptocurrencies/node/src/seal.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/soundness.rs` | `L2-cryptocurrencies/node/src/soundness.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/store.rs` | `L2-cryptocurrencies/node/src/store.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/testnet.rs` | `L2-cryptocurrencies/node/src/testnet.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/transport.rs` | `L2-cryptocurrencies/node/src/transport.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/tx.rs` | `L2-cryptocurrencies/node/src/tx.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/ui/app.css` | `L2-cryptocurrencies/node/src/ui/app.css` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/ui/app.js` | `L2-cryptocurrencies/node/src/ui/app.js` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/ui/index.html` | `L2-cryptocurrencies/node/src/ui/index.html` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/ui/wallet.html` | `L2-cryptocurrencies/node/src/ui/wallet.html` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/src/walletweb.rs` | `L2-cryptocurrencies/node/src/walletweb.rs` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/tools/gen.log` | `L2-cryptocurrencies/node/tools/gen.log` |
| `L2 - Cryptocurrencies/zen-rust/zenproof/tools/gen_reward_tables.py` | `L2-cryptocurrencies/node/tools/gen_reward_tables.py` |
| `L2 - Cryptocurrencies/jen0-go-devnet/NOTE.md` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/NOTE.md` |
| `L2 - Cryptocurrencies/jen0-go-devnet/README.md` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/README.md` |
| `L2 - Cryptocurrencies/jen0-go-devnet/attack_hidden.sh` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/attack_hidden.sh` |
| `L2 - Cryptocurrencies/jen0-go-devnet/balance.go` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/balance.go` |
| `L2 - Cryptocurrencies/jen0-go-devnet/blow.go` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/blow.go` |
| `L2 - Cryptocurrencies/jen0-go-devnet/chain.go` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/chain.go` |
| `L2 - Cryptocurrencies/jen0-go-devnet/circuit.go` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/circuit.go` |
| `L2 - Cryptocurrencies/jen0-go-devnet/claims.go` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/claims.go` |
| `L2 - Cryptocurrencies/jen0-go-devnet/coinweight.go` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/coinweight.go` |
| `L2 - Cryptocurrencies/jen0-go-devnet/combined_test.sh` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/combined_test.sh` |
| `L2 - Cryptocurrencies/jen0-go-devnet/devnet_ab.sh` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/devnet_ab.sh` |
| `L2 - Cryptocurrencies/jen0-go-devnet/main.go` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/main.go` |
| `L2 - Cryptocurrencies/jen0-go-devnet/node.go` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/node.go` |
| `L2 - Cryptocurrencies/jen0-go-devnet/params.go` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/params.go` |
| `L2 - Cryptocurrencies/jen0-go-devnet/peg.go` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/peg.go` |
| `L2 - Cryptocurrencies/jen0-go-devnet/quiet_test.sh` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/quiet_test.sh` |
| `L2 - Cryptocurrencies/jen0-go-devnet/reward.go` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/reward.go` |
| `L2 - Cryptocurrencies/jen0-go-devnet/run_devnet.sh` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/run_devnet.sh` |
| `L2 - Cryptocurrencies/jen0-go-devnet/split_test.sh` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/split_test.sh` |
| `L2 - Cryptocurrencies/jen0-go-devnet/state.go` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/state.go` |
| `L2 - Cryptocurrencies/jen0-go-devnet/types.go` | `L2-cryptocurrencies/prototypes/jen0-go-devnet/types.go` |
| `L2 - Cryptocurrencies/pom-leaf-go/README.md` | `L2-cryptocurrencies/prototypes/pom-leaf-go/README.md` |
| `L2 - Cryptocurrencies/pom-leaf-go/main.go` | `L2-cryptocurrencies/prototypes/pom-leaf-go/main.go` |
| `L2 - Cryptocurrencies/Simulate_Supply.py` | `L2-cryptocurrencies/prototypes/supply-simulation/Simulate_Supply.py` |
| `L3 - Channel Factories/README.MD` | `L3-channel-factories/README.md` |
| `LICENSE` | `LICENSE` |
| `README.md` | `README.md` |
| `Data Minting/README.md` | `data-minting/README.md` |
| `Data Minting/ad.gif` | `data-minting/ad.gif` |
| `Data Minting/mario.gif` | `data-minting/mario.gif` |
| `Data Minting/mint.py` | `data-minting/mint.py` |
| `Data Minting/pic.jpg` | `data-minting/pic.jpg` |
| `docs/index.html` | `docs/index.html` |
| `img/donate.png` | `img/donate.png` |
| `img/zen.png` | `img/zen.png` |
| `simulations/README.md` | `simulations/README.md` |
| `simulations/js/bondsize.js` | `simulations/js/bondsize.js` |
| `simulations/js/daywin.js` | `simulations/js/daywin.js` |
| `simulations/js/model.js` | `simulations/js/model.js` |
| `simulations/js/model2.js` | `simulations/js/model2.js` |
| `simulations/js/model3.js` | `simulations/js/model3.js` |
| `simulations/js/pegdef.js` | `simulations/js/pegdef.js` |
| `simulations/js/pegdef2.js` | `simulations/js/pegdef2.js` |
| `simulations/js/pegsize.js` | `simulations/js/pegsize.js` |
| `simulations/js/q.js` | `simulations/js/q.js` |
| `simulations/js/receivers.js` | `simulations/js/receivers.js` |
| `simulations/js/results/.gitkeep` | `simulations/js/results/.gitkeep` |
| `simulations/js/results/pegdef.json` | `simulations/js/results/pegdef.json` |
| `simulations/js/results/pegdef.txt` | `simulations/js/results/pegdef.txt` |
| `simulations/js/results/tri2.txt` | `simulations/js/results/tri2.txt` |
| `simulations/js/sim.js` | `simulations/js/sim.js` |
| `simulations/js/tri.js` | `simulations/js/tri.js` |
| `simulations/js/tri2.js` | `simulations/js/tri2.js` |
| `simulations/js/twounit.js` | `simulations/js/twounit.js` |
| `simulations/js/volsim.js` | `simulations/js/volsim.js` |
| `simulations/js/volsim2.js` | `simulations/js/volsim2.js` |
| `simulations/js/wanchor.js` | `simulations/js/wanchor.js` |
| `simulations/python/detect9.py` | `simulations/python/detect9.py` |
| `simulations/python/detect_sim.py` | `simulations/python/detect_sim.py` |
| `simulations/python/pom_simulation.py` | `simulations/python/pom_simulation.py` |
| `simulations/python/zen_minting.py` | `simulations/python/zen_minting.py` |
| `whitepaper/README.md` | `whitepaper/README.md` |
| `whitepaper/Zen-white-paper-draft-0.4.pdf` | `whitepaper/Zen-white-paper-draft-0.4.pdf` |
| `whitepaper/Zen_peg_prior_art_and_economics.md` | `whitepaper/Zen_peg_prior_art_and_economics.md` |
| `whitepaper/figs.py` | `whitepaper/figs.py` |
| `whitepaper/figs/ab.pdf` | `whitepaper/figs/ab.pdf` |
| `whitepaper/figs/blowbench.pdf` | `whitepaper/figs/blowbench.pdf` |
| `whitepaper/figs/capacity.pdf` | `whitepaper/figs/capacity.pdf` |
| `whitepaper/figs/coindays.pdf` | `whitepaper/figs/coindays.pdf` |
| `whitepaper/figs/converge.pdf` | `whitepaper/figs/converge.pdf` |
| `whitepaper/figs/copper.pdf` | `whitepaper/figs/copper.pdf` |
| `whitepaper/figs/costs.pdf` | `whitepaper/figs/costs.pdf` |
| `whitepaper/figs/daywin.pdf` | `whitepaper/figs/daywin.pdf` |
| `whitepaper/figs/defender.pdf` | `whitepaper/figs/defender.pdf` |
| `whitepaper/figs/detect.pdf` | `whitepaper/figs/detect.pdf` |
| `whitepaper/figs/detect9.pdf` | `whitepaper/figs/detect9.pdf` |
| `whitepaper/figs/exchange.pdf` | `whitepaper/figs/exchange.pdf` |
| `whitepaper/figs/hidden.pdf` | `whitepaper/figs/hidden.pdf` |
| `whitepaper/figs/launch.pdf` | `whitepaper/figs/launch.pdf` |
| `whitepaper/figs/purity.pdf` | `whitepaper/figs/purity.pdf` |
| `whitepaper/figs/split.pdf` | `whitepaper/figs/split.pdf` |
| `whitepaper/figs/supply.pdf` | `whitepaper/figs/supply.pdf` |
| `whitepaper/figs/throughput.pdf` | `whitepaper/figs/throughput.pdf` |
| `whitepaper/figs/ui_main.jpg` | `whitepaper/figs/ui_main.jpg` |
| `whitepaper/figs/ui_mine.jpg` | `whitepaper/figs/ui_mine.jpg` |
| `whitepaper/figs/ui_mint.jpg` | `whitepaper/figs/ui_mint.jpg` |
| `whitepaper/figs/ui_phone.jpg` | `whitepaper/figs/ui_phone.jpg` |
| `whitepaper/figs/ui_wallet.jpg` | `whitepaper/figs/ui_wallet.jpg` |
| `whitepaper/figs/ui_weight.jpg` | `whitepaper/figs/ui_weight.jpg` |
| `whitepaper/figs/window.pdf` | `whitepaper/figs/window.pdf` |
| `whitepaper/figs/zkpipeline.pdf` | `whitepaper/figs/zkpipeline.pdf` |
| `whitepaper/sec1.tex` | `whitepaper/sec1.tex` |
| `whitepaper/sec2.tex` | `whitepaper/sec2.tex` |
| `whitepaper/sec3.tex` | `whitepaper/sec3.tex` |
| `whitepaper/sec4.tex` | `whitepaper/sec4.tex` |
| `whitepaper/zen-whitepaper.tex` | `whitepaper/zen-whitepaper.tex` |
