# Security

**Zen is a research prototype on a test network. Do not put anything of value on it.**

- The test coins have no value.
- The code has not been audited by anyone outside the project.
- The Groth16 proving key comes from a single-party setup: whoever ran it could forge block proofs. A public ceremony is required before any real use.
- The default test network uses stand-in stamps that prove nothing.
- Wallet key files are stored unencrypted.

## Reporting a problem

Because nothing of value is at stake, findings can be reported in public: open an issue using the format in [`REVIEWING.md`](REVIEWING.md). If you believe a finding should not be public yet, contact the author first through the channels on the project page ([`docs/index.html`](docs/index.html)).

## Where the known problems are listed

- [`docs/KNOWN-ISSUES.md`](docs/KNOWN-ISSUES.md): confirmed defects, design limits and open questions for the whole repository.
- [`L2-cryptocurrencies/node/docs/SECURITY-REVIEW.md`](L2-cryptocurrencies/node/docs/SECURITY-REVIEW.md): the author's internal review of the node (findings, accepted risks, and what an outside auditor should cover).
