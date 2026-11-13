# Zen: one place for the common commands. Run `make` or `make help` to list them.
# Every target is a thin wrapper; the READMEs show the same commands in full.
NODE := L2-cryptocurrencies/node
Z    := $(NODE)/target/release/zenproof
NET  ?= /tmp/zen-net
export RUSTC_BOOTSTRAP := 1

.PHONY: help build fmt-check test-fast test test-soundness net serve mine status demo sims-fast paper clean
help:            ## list the targets
	@grep -E '^[a-z-]+: .*##' $(MAKEFILE_LIST) | sed -E 's/:.*## /\t/' | awk -F'\t' '{printf "  make %-16s %s\n", $$1, $$2}'
build:           ## build the node (2 to 10 minutes)
	cd $(NODE) && cargo build --release
fmt-check:       ## check that the Rust code is formatted
	cd $(NODE) && cargo fmt --check
test-fast:       ## the quick tests: header, storage, wire, reward, verifier, wallet (about a minute once built)
	cd $(NODE) && cargo test --release -- seal:: store:: transport:: reward:: groth16:: tx:: mempool::
test:            ## every test (25 to 35 minutes on 2 cores; expect 139 passed)
	cd $(NODE) && cargo test --release
test-soundness:  ## the 583 rule-breaking tries against the operation circuits (about 10 minutes)
	cd $(NODE) && cargo test --release soundness::
net: build       ## make a fresh three-chain test network in $(NET)
	rm -rf $(NET) && $(Z) net init all $(NET)
serve:           ## run the three chains (leave it running; Ctrl+C stops it)
	$(Z) node serve-all $(NET)
mine:            ## mine 3 blocks on each chain (needs `make serve` in another terminal)
	for p in 18450 18451 18452; do $(Z) node mine 127.0.0.1:$$p 3; done
status:          ## print each chain's height from its API
	@for p in 18460 18461 18462; do curl -s http://127.0.0.1:$$p/api/status | head -c 160; echo; done
demo:            ## run the market demo (orders, rates, auction); it restarts the test network
	bash $(NODE)/scripts/demo_market.sh
sims-fast:       ## two simulations that finish in seconds
	python3 simulations/python/detect_sim.py
	node simulations/js/tri2.js
paper:           ## build the white paper PDF (needs pdflatex)
	cd whitepaper && pdflatex -interaction=nonstopmode zen-whitepaper.tex >/dev/null && pdflatex -interaction=nonstopmode zen-whitepaper.tex >/dev/null && ls -la zen-whitepaper.pdf
clean:           ## remove build outputs
	cd $(NODE) && cargo clean
