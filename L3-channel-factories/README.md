# Layer 3: Channel Factories (streaming)

Payment channels and channel factories: coins are *melted* into a channel, *streamed* off chain, and *cast* back on chain. This layer answers point 5 of the six monetary points ("stream physical coins").

> This folder holds notes only. The implementation lives in the node, and it runs today on the test network.

## Where the implementation is

| Topic | Place |
|---|---|
| Design | white paper, sections "Channels and channel factories" and "Zen Net: a paid network layer" ([`../whitepaper`](../whitepaper)) |
| On-chain rules of channels and factories | [`../L2-cryptocurrencies/node/src/locks.rs`](../L2-cryptocurrencies/node/src/locks.rs) (`Terms::Channel`, `Terms::Factory`) |
| Their proof circuits | `chancirc.rs`, `factorycirc.rs` in the same folder |
| Off-chain state and the `chan` commands | `channel.rs` |
| Routing node, onion routes, watchtower | `route.rs` |
| Encrypted wire between channel peers | `transport.rs` |
| Build notes | [`../L2-cryptocurrencies/node/docs/BUILD-LOG.md`](../L2-cryptocurrencies/node/docs/BUILD-LOG.md), rounds 37 to 45 |

## Try it

Build the node first ([`../L2-cryptocurrencies/node/README.md`](../L2-cryptocurrencies/node/README.md), section 1), then from `L2-cryptocurrencies/node`:

```bash
bash scripts/demo_channels_1.sh   # open a channel on Ken, pay off chain
bash scripts/demo_channels_2.sh   # cooperative close; then an attempt to close with an old state
bash scripts/demo_factory.sh      # one on-chain output behind three members
bash scripts/demo_routing.sh      # a payment routed Jen -> Ken -> Yen
bash scripts/demo_tower.sh        # a watchtower defends an offline owner
```

Each script prints its steps (lines starting with `==`) and the commands' output. Run one at a time: each restarts the test network.

## How to review

Read the rules in `locks.rs` for the channel and factory operations, then ask: can a party who follows the protocol lose money? What must a watchtower know, and what can it do with it? [`../REVIEWING.md`](../REVIEWING.md) lists more questions.

---

*The text below is the original project note (2020).*

## Zen
Zen : A Decentralized Gold/Silver/Copper Monetary System.
(This project is still under research and developpement)

Zen ("The Balance", "ⵣⴻⵏ", "全", "الميزان") is a decentralized monetary system build into 3 layers :
  - Physical Coins (RTS)
  - Cryptocurrencies (YKJ)
  - Channel Factories (YKJ-Channels)
  
### Points 
Zen try to solve 6 monetary points :
  1) Mint physical coins
  2) Verify physical coins
  3) Store physical coins
  4) Send physical coins
  5) Stream physical coins
  6) Geographical Wealth distribution