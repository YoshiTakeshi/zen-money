# Layer 2: Cryptocurrencies (Yen, Ken, Jen)

Three linked proof-of-work chains, one per metal. Each block carries one 196-byte zero-knowledge proof that its payments and operations follow the rules.

## What is in this folder

| Folder | What it is | Status | Start with |
|---|---|---|---|
| [`node/`](node) | the reference node, wallet, three-chain test network and proof circuits (Rust) | current work | [`node/README.md`](node/README.md) |
| [`groth16-wrap/`](groth16-wrap) | the last proof step: the Plonky2 block proof wrapped into a 196-byte Groth16 proof (Go, gnark) | current work, heavy to run | [`groth16-wrap/README.md`](groth16-wrap/README.md) |
| [`benchmarks/`](benchmarks) | six small Rust programs that compared Plonky2, Nova and Groth16 on the same workload and led to the current design | finished, kept as evidence | [`benchmarks/README.md`](benchmarks/README.md) |
| [`prototypes/`](prototypes) | the first Go prototypes of collaborative minting (2026) and the supply simulation (2020) | superseded by `node/` | [`prototypes/README.md`](prototypes/README.md) |

**If you only have ten minutes:** build and run the node ([`node/README.md`](node/README.md), sections 1 and 2).

**How the parts fit:** minters prove groups of payments (leaves); a builder merges them into one Plonky2 proof for the block (`node/src/main.rs`, `prover.rs`); `groth16-wrap` compresses that proof to 196 bytes; every node checks it in a few milliseconds (`node/src/groth16.rs`); a miner seals the block with SHA-256 (`node/src/seal.rs`). The benchmarks are the experiments that chose this pipeline.

---

*The text below is the original design note (2020).*

## Cryptocurrencies

Zen's Cryptocurrencies are 3-in-1 cryptographic coins :
  - Golden ratio coins (YEN)
  - Silver ratio coins (KEN)
  - Bronze ratio coins (JEN)

### Points 
Zen's Cryptocurrencies try to solve 2 of the 6 monetary points :
  1) Mint physical coins
  2) Verify physical coins
  3) **Store physical coins**
  4) **Send physical coins**
  5) Stream physical coins
  6) Geographical Wealth distribution

#### Store physical coins : What is the most secure way to store physical coins?
To solve the storage problem, we will use cryptocurrencies.

The cryptocurrencies auto-adjust their own value such as 1 unit of the cryptocurrency is equal to 1 physical coin. To store a physical coins, people can just exchange them into the respective cryptocurrency and store or memorize the private key.

This way is like storing physical coin is the economy itself, and get an E.O.U (economy owe you) in exchange. where the E.O.U is the cryptocurrency.

#### Send physical coins : What is the most secure way to send physical coins?
By default cryptocurrency solve this point. Sending 1 unit of the cryptocurrency is the same as sending 1 physical coin to someone.
