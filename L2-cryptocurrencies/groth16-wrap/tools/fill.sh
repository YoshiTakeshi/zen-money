#!/bin/bash
# run a go command; whenever it fails on a missing module version, build it from GitHub and retry
HERE="$(cd "$(dirname "$0")/.." && pwd)"   # the groth16-wrap folder; the local module proxy is built in $HERE/goproxy
export GOPROXY=file://$HERE/goproxy GOSUMDB=off GOFLAGS=-mod=mod GOTOOLCHAIN=local GONOSUMDB='*'
GO=${GO:-go}
for i in $(seq 1 60); do
  out=$($GO "$@" 2>&1); rc=$?
  if [ $rc -eq 0 ]; then echo "OK after $i rounds"; exit 0; fi
  miss=$(echo "$out" | grep -oE '[a-zA-Z0-9./_~-]+@v[0-9][a-zA-Z0-9.+_-]*' | sort -u)
  # "@latest"/list queries: pick nothing, print and stop
  if [ -z "$miss" ]; then echo "$out" | tail -20; exit 1; fi
  : > /tmp/need.sum
  for m in $miss; do echo "${m%@*} ${m#*@} h1:x" >> /tmp/need.sum; done
  before=$(find "$HERE/goproxy" -name '*.zip' | wc -l)
  python3 "$HERE/tools/goproxy.py" "$HERE/goproxy" /tmp/need.sum | grep -v '^ok'
  after=$(find "$HERE/goproxy" -name '*.zip' | wc -l)
  if [ "$before" = "$after" ]; then echo "no progress:"; echo "$out" | tail -20; exit 1; fi
done
