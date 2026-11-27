#!/bin/sh
set -eu
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
PAGE="$ROOT/site/index.html"
test -s "$PAGE"
for name in DOSERA PIXEL MOSAIC FORGE NOVA HORIZON AEROLITH PRISM LUMEN TILESHIFT METROVA; do
  grep -q "$name" "$PAGE" || { echo "Missing style: $name" >&2; exit 1; }
done
for edition in "ASTRAL Classic" "ASTRAL Modern" "ASTRAL Legacy"; do
  grep -q "$edition" "$PAGE" || { echo "Missing edition: $edition" >&2; exit 1; }
done
grep -q '/api/releases' "$PAGE"
grep -q 'Limbo' "$PAGE"
echo "ASTRAL portal checks passed."
