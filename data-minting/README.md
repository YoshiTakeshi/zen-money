# Data Minting (2020 prototype)

> **Status:** an early experiment from 2020, kept for the record. It is not used by the node. The related idea in the current design is tested in [`../simulations/python/zen_minting.py`](../simulations/python/zen_minting.py) (the anti-prime encoder).

A first version of the Data Minting algorithm. It reads a file, turns its bytes into points using anti-prime numbers, orders the points as a Travelling Salesman route, encodes the route as one long integer and writes it out ("minting"). It then reads that file back and restores the original ("deminting").

The test file is `mario.gif` (1,165 bytes). The minted file is bigger (2,390 bytes): the goal of the experiment was to improve the route and the encoding until a minted file gets smaller. That goal was not reached.

## Run it

Needs Python 3 and `matplotlib` (`pip install matplotlib`).

```bash
cd data-minting
PYTHONINTMAXSTRDIGITS=0 MPLBACKEND=Agg python3 mint.py
cmp mario.gif deminted.mario.gif && echo "round trip identical"
```

- `PYTHONINTMAXSTRDIGITS=0` is needed on Python 3.11 and newer: the script prints an integer of many thousand digits, which newer Pythons refuse by default.
- `MPLBACKEND=Agg` skips the plot window. Leave it out to see the route drawn.

It takes a few seconds and writes three files: `data.zen` (a cache of anti-primes), `mario.gif.minted.out` (the minted file) and `deminted.mario.gif` (the restored file, identical to the input). Checked on 13 November 2026 with Python 3.13.

## Files

| File | Content |
|---|---|
| `mint.py` | the whole prototype; the file to mint is set near the end (`File_name = "mario.gif"`) |
| `mario.gif` | the 1 kB test input |
| `ad.gif`, `pic.jpg` | larger inputs to try |
