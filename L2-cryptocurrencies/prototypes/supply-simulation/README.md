# Supply simulation (2020)

`Simulate_Supply.py` simulates one year of block rewards for Golden Yen (15-minute blocks), Silver Ken (5 minutes) and Bronze Jen (2.5 minutes). Each block pays `2520 x 0.5^(ln N / ln r)` times a random factor `r^Z`, where `r` is the chain's metallic ratio (golden, silver, bronze) and `Z` is a standard normal draw. It plots the three supply curves and prints the final supplies and their ratios.

> **Status:** the original 2020 script, unchanged. The reward rule it explores is now implemented in integers in [`../../node/src/reward.rs`](../../node/src/reward.rs) and described in the white paper, section "The reward curve".

## Run it

The script is **Python 2** (it uses `print` statements). With Python 2.7, `scipy` and `matplotlib` installed:

```bash
python2 Simulate_Supply.py
```

On a machine with only Python 3, convert a copy first (the only Python 2 construct is the `print` statement):

```bash
pip install scipy matplotlib
sed -E 's/^( *)print (.*[^,]),?$/\1print(\2)/' Simulate_Supply.py > /tmp/supply3.py
MPLBACKEND=Agg python3 /tmp/supply3.py        # leave MPLBACKEND out to see the plot
```

It takes under a minute and ends with lines like these (the numbers change from run to run, because the reward has a random factor):

```
Golden Yen Supply : 10418.85...
Silver Ken Supply : 199802.40...
Bronze Jen Supply : 2131490.58...
KEN/YEN : 19.17...
JEN/KEN : 10.66...
JEN/YEN : 204.58...
```

Checked this way on 13 November 2026 with Python 3.13.
