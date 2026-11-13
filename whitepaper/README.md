# White paper

[`Zen-white-paper-draft-0.4.pdf`](Zen-white-paper-draft-0.4.pdf) is the current draft (47 pages). Read this first if you want the design rather than the code.

> **Status:** a draft. Statements are tagged in the text as *Decided*, *Open*, *Proposed* or *benchmarked*, so you can see what is settled.

## Files

| File | Content |
|---|---|
| `Zen-white-paper-draft-0.4.pdf` | the built paper |
| `zen-whitepaper.tex` | the main LaTeX file: title, abstract, macros; includes the four section files |
| `sec1.tex` | introduction, the system at a glance, chain parameters and issuance, accounts and payments |
| `sec2.tex` | Proof of Minting (blows, tickets, leaves, the stamp, block data), mining and consensus |
| `sec3.tex` | block size and purity, the coin weight (the peg), three currencies as a self-correcting system |
| `sec4.tex` | channels and factories, exchange, Zen Net, upgrades, implementation, economics, security summary, open problems, simulation methods, glossary |
| `figs/` | the figures as PDF, and screenshots of the interface |
| `figs.py` | the script that drew the figures (see the note below) |
| `Zen_peg_prior_art_and_economics.md` | the prior-art study for the metal peg |

## Build the PDF

Needs a TeX distribution with `pdflatex`, TikZ and the Palatino fonts (TeX Live "full", or MacTeX).

```bash
cd whitepaper
pdflatex zen-whitepaper.tex
pdflatex zen-whitepaper.tex      # the second run fixes the cross-references
```

Result: `zen-whitepaper.pdf`, 47 pages. Checked on 13 November 2026 with TeX Live.

## Regenerating the figures: not possible yet

`figs.py` reads `data/series.json` and `data/launch.json`, and these two files are **not in the repository**. The finished figures in `figs/` are, so the paper builds; only redrawing them is blocked until the data files are added. The models that produced the numbers are in [`../simulations`](../simulations).

## How to review

- The peg argument: sections "The coin weight" and "Three currencies, six coins". What assumptions do the defences rest on? What does an attack cost?
- "Security summary" and "Open problems and roadmap" list what the author already considers open.
- Compare claims tagged *benchmarked* with the logs in [`../L2-cryptocurrencies/node/logs`](../L2-cryptocurrencies/node/logs) and [`../L2-cryptocurrencies/benchmarks`](../L2-cryptocurrencies/benchmarks).

For a reader that prefers text to PDF (an AI assistant, for example), the `.tex` files are the same content.
