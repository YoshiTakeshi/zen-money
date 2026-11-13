# Simulations

Models that test the rules of Zen: the peg (does one electronic coin hold the value of one physical coin, and what does it cost to push it?), block resizing, the detection of attacks across three chains, and Proof of Minting. The numbers quoted in the white paper's sections on the coin weight and on three currencies come from these files (see also its appendix "Simulation methods").

> These are models, not measurements. Each one states its assumptions in the comment at the top of the file; those assumptions are what a reviewer should question first.

## Run one

No build step. From this folder:

```bash
node js/tri2.js                    # 1 second
python3 python/detect_sim.py       # 2 seconds
```

- **JavaScript models** need only Node.js (18 or newer), no packages. Each prints a table and also writes it to `js/results/<name>.txt`.
- **Python models** need Python 3; `detect_sim.py` and `detect9.py` need `numpy`, and `pom_simulation.py` needs `cryptography` (`pip install numpy cryptography`). `detect_sim.py` and `detect9.py` also write a JSON file to `python/results/`.

Every model uses a fixed random seed, so it prints the same numbers on every run.

## The models

Times were measured on 13 November 2026 on a 2-core machine that was running two models at once, so read them as upper bounds.

### The peg and the reading of S

| File | Question | Time |
|---|---|---|
| `js/tri2.js` | Three chains whose exchange trades feed the coin weight: how far can a 30-day attack move each chain's S? | 1 s |
| `js/tri.js` | Three chains, each with its own peg, an exchange between them and a three-way brake | 20 s |
| `js/pegdef.js` | Four defences against fake payments that try to move the peg | 1.5 min |
| `js/pegdef2.js` | Defences, round 2: robust block statistic, anchor, speed by share | 3.5 min |
| `js/daywin.js` | Reading S with a window counted in days | 1 min |
| `js/receivers.js` | Counting a payment only when its receiver is bonded and under its cap | 1 min |
| `js/bondsize.js` | A bond that grows under pressure | 1.5 min |
| `js/volsim.js` | Reading S by volume, each gram counted once per rest period | 2.5 min |
| `js/volsim2.js` | Coin-days and the bond penalty on top of the full set of defences | 4.5 min |
| `js/twounit.js` | Two units on one chain: the typical payment W and the Sen unit S | 45 s |
| `js/wanchor.js` | W with and without a loose anchor | 4.5 min |
| `js/pegsize.js` | Can block resizing steer W toward the Sen unit? | 15 s |

W (the typical payment size) set the fee limits in earlier drafts and was removed from the design in October 2026; `twounit.js`, `wanchor.js` and `pegsize.js` document that earlier design.

### Detecting attacks across chains

| File | Question | Time |
|---|---|---|
| `python/detect_sim.py` | How fast is a push on one chain's S detected, and can it be attributed, with two linked chains versus three? | 2 s |
| `python/detect9.py` | The same with the nine public readings every node sees; names the biased components. Set `SCALE=3` for thin, young markets | 6 min |

### Minting

| File | Question | Time |
|---|---|---|
| `python/pom_simulation.py` | Proof of Minting end to end with real Ed25519 signatures and SHA-256 blows and seals; the zero-knowledge proofs are simulated records | 20 s |
| `python/zen_minting.py` | Collaborative block minting and the anti-prime encoder (standard library only) | 4 min |
| `js/sim.js` | The block-resize rule: the old rule against the balanced rule, six scenarios, attack cost. Writes `js/results.json` and `js/results.txt` | **heavy:** it was stopped after 13 minutes at about 5 GB of memory. Not completed during the clean-up |
| `js/q.js [S0 S1 ...]` | Runs chosen scenarios of `sim.js` and prints a few rows of each | **heavy:** about 4 GB of memory and several minutes per scenario. Not completed during the clean-up |

### Libraries (no output when run directly)

`js/model.js`, `js/model2.js` and `js/model3.js` export a function and its default parameters. Call them from Node:

```bash
cd js
node -e "const m=require('./model.js');  const r=m.simulate(m.DEFAULTS);    console.log(r.pegHours, 'peg hours of', r.hours)"
node -e "const m=require('./model2.js'); const r=m.simulate2(m.DEFAULTS2);  console.log(r.series.at(-1))"
node -e "const m=require('./model3.js'); const r=m.simulate3(m.DEFAULTS3);  console.log(Object.keys(r))"
```

| File | Model |
|---|---|
| `js/model.js` | Does 1 Jen = 1 Sen hold as more people agree? Hourly market, two years |
| `js/model2.js` | Two coins, one value: physical Sen and electronic Jen side by side, with printers and melters |
| `js/model3.js` | Denomination payments and the ratio rule for W |

## Stored results

`js/results/` holds the author's outputs for `pegdef` and `tri2`. Running a model overwrites its file there; `git diff` then shows whether your run matches. During the clean-up, `tri2.js` and `pegdef.js` reproduced the stored files exactly.

## How to review a model

1. Read the comment at the top: units, time step, who the actors are, what the attacker can do.
2. Find the parameters (constants near the top) and ask which ones the conclusion depends on. Change one and rerun.
3. Compare the printed table with the claim in the white paper that cites it.
4. Report an assumption you think is unfair to the attacker, with the changed parameter and the new output.
