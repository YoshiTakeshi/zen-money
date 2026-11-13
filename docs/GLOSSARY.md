# Glossary

Zen borrows its words from metalworking. This page collects them, with the place in the code or the paper where each one is defined. The first table follows the glossary of the white paper (section "Glossary"); the second adds the terms used in the code and the build log.

## Coins and units

| Term | Meaning |
|---|---|
| Ren, Ten, Sen | the physical coins: 4 g of gold, 3 g of silver, 2 g of copper |
| Yen, Ken, Jen | the electronic coins on the three chains (chain ids 1, 2, 3), twins of Ren, Ten, Sen |
| Base unit | the smallest amount on a chain: one nanogram. 1 g = 1,000,000,000 base units |
| **S** | the coin weight: base units per electronic coin, read by the chain from its own payments so that one coin equals one physical coin (`node/src/reading.rs`, white paper section "The coin weight") |
| Anchor | a slow copy of S that moves at most 2.9% a day; S must stay within ±10% of it |
| Coin-priced | a payment of an exact number of sixths of a coin: the shop priced in coins |
| Coin-days | the weight of a counted payment by how long its money rested, up to 30 days |
| Fineness / purity | a payment's fee rate written like metal purity (940 = 6%, 9999 = 0.01%); purity is the day's geometric mean |
| W | the typical payment size; it set the fee limits in earlier drafts and was removed in October 2026. Some simulations still model it |

## Making a block (Proof of Minting, then mining)

| Term | Meaning |
|---|---|
| Minter | a phone or PC that makes blows and proves signature leaves. Its address is its *hammer* |
| Blow | one signed Argon2id attempt (64 MB) at the minting puzzle (`node/src/mint.rs`) |
| Ticket | a winning blow recorded in a block: 105 bytes (public key, nonce, signature) |
| Credential | the right to prove leaves, held while one's ticket is in the recent chain |
| Strike | a proving task (word used by the Go prototypes and the paper) |
| Leaf | a group of 4 to 16 payments with one zero-knowledge proof. A *signature leaf* (made by a minter) checks signatures and fees; a *state leaf* (made by the builder) applies the payments to the account tree. An *operation leaf* proves one vault, channel, order or factory operation |
| Merge | a recursive proof that joins two proofs whose state roots chain; a tree of merges gives one proof for the block |
| Shrink, BN254 layer | two more Plonky2 proofs that make the block proof small and cheap to verify inside Groth16 |
| Stamp | the single proof of a whole block: a 196-byte Groth16 proof on BN254, checked in a few milliseconds (`node/src/groth16.rs`, `groth16-wrap/`) |
| Stand-in stamp | a hash used in place of the stamp on the test network so that no prover hardware is needed. It proves nothing (`DevStamp` in `node/src/node.rs`) |
| Builder | turns minters' signature leaves into a block: state leaves, merges and the stamp; in practice a mining pool |
| Miner | seals the block with SHA-256 hardware |
| Seal | the miner's SHA-256 proof of work over Bitcoin's 80-byte header (`node/src/seal.rs`) |
| Ingot | a full minted block (paper) |
| Credit | a payout applied inside the proof: fee shares of provers and miner, rewards (`node/src/blockdata.rs`) |
| Fee pool | half of each leaf's fees goes into it; it pays out 1/32 of what it holds per block |
| Public values | the numbers a stamp proves: state root before and after, fee total, payment count, block-data hash and the block header values the rules need |

## Locks, channels and exchange

| Term | Meaning |
|---|---|
| Lock | an account-tree leaf whose address is a digest of its terms, so nobody can sign for it: a vault, an order, a channel or a factory (`node/src/locks.rs`) |
| Vault | coins locked to a key until a time or a claim |
| Order | coins offered for another chain's coin; filled when the taker proves the payment on the other chain |
| Batch auction | an order that collects bids for a window; the highest bid wins |
| Channel | a two-party lock whose balance is updated off chain by signed states |
| Melt, stream, cast | enter a channel, pay off chain, settle back on chain |
| Point lock | a conditional payment inside a channel that opens with a secret scalar (a PTLC); used for routing |
| Factory | one on-chain output behind up to eight members, each with a channel to a coordinator |
| Watchtower | a helper that holds a channel owner's newest signed state and posts it if an old state is closed on chain |
| Official rate | an exchange rate worked out from filled orders, announced by nobody (`node/src/market.rs`) |
| Coin point | a place (a shop) that exchanges physical coins and electronic coins |

## Words from the build log and the code

| Term | Meaning |
|---|---|
| Round N | one step of the build, numbered 11 to 56 in `node/docs/BUILD-LOG.md` |
| Stage N / P1 to P7 | milestones of the node (stages) and of the proof coverage (P steps, `node/docs/PROOFS-PLAN.md`) |
| SPEC x.y | a section of the Zen Protocol Specification the code comments cite. The specification is not a separate file in this repository; the white paper is the closest public text |
| Jen-0, Jen-0.x | versions of the first Go devnet (`L2-cryptocurrencies/prototypes/jen0-go-devnet`) |
| Devnet | a single chain in one process with fixed test keys (`zenproof node devnet`) |
| Test network | the three chains together (`zenproof net init all`, `node serve-all`) |
| EcGFp5 | the elliptic curve over GF(p^5), p = Goldilocks, used for signatures (T. Pornin's curve; `node/src/ec.rs`) |
| `REVIEW:` | a marker in code comments at places an auditor should look first |
