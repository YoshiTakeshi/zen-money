# Prototypes

Earlier experiments, kept as they were written. They are **superseded by [`../node`](../node)**: read them to see where an idea came from, not to learn the current rules.

| Folder | What it is | Language | Can I run it? |
|---|---|---|---|
| [`jen0-go-devnet/`](jen0-go-devnet) | "Jen-0": the first working devnet of Proof of Minting. Several nodes mint blocks together with real Groth16 proofs, miners seal them, an attacker node tries stolen and forged strikes | Go, gnark | yes, after creating a `go.mod` (below) |
| [`pom-leaf-go/`](pom-leaf-go) | the very first zero-knowledge "leaf strike": one proof for K signed transfers | Go, gnark | yes, after creating a `go.mod` |
| [`supply-simulation/`](supply-simulation) | the 2020 simulation of the coin supply of Yen, Ken and Jen over one year | Python 2 | see its README |

## Building the Go prototypes

Neither Go folder has a `go.mod`, and they were **not rebuilt** when this repository was assembled (see `jen0-go-devnet/NOTE.md`). To try one:

```bash
cd jen0-go-devnet
go mod init jen0
go mod tidy            # downloads gnark; pick a gnark version that matches your Go version
go build -o jen0 .
./jen0 setup --keys keys && ./jen0 selftest keys
```

Then follow [`jen0-go-devnet/README.md`](jen0-go-devnet/README.md). If this does not build with a current gnark, please open an issue with the Go and gnark versions you used: pinning working versions in a `go.mod` is a welcome contribution.

## What changed afterwards

| In Jen-0 (Go) | In the node (Rust) |
|---|---|
| leaf proofs certify signatures and fee limits; every node executes balances | leaf proofs also prove the account-tree update |
| the block carries a list of leaf proofs | recursive merges give one 196-byte stamp |
| SHA-256 blows | Argon2id blows signed with the payment key |
| HTTP gossip, keys from seeds | a peer protocol, wallets, Stratum for miners |
