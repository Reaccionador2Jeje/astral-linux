#!/bin/sh
set -eu
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
sh -n "$ROOT/installers/iso/build-iso.sh"
test -s "$ROOT/installers/iso/config/package-lists/astral.list.chroot"
test -s "$ROOT/desktop/pixel/astral-pixel.desktop"
test -s "$ROOT/desktop/pixel/openbox/rc.xml"
test -s "$ROOT/desktop/pixel/tint2/tint2rc"
grep -q 'Penguins' "$ROOT/installers/iso/README.md"
grep -q 'eggs remaster' "$ROOT/installers/iso/README.md"
grep -q 'docker create --privileged' "$ROOT/installers/iso/README.md"
if grep -R -n -E '(^|[[:space:]])lb (config|build)|live-build' "$ROOT/installers/iso/build-iso.sh" "$ROOT/.github/workflows/iso-build.yml"; then
  echo "Live-Build references remain in the active ISO pipeline." >&2
  exit 1
fi
echo "ASTRAL Penguins' Eggs ISO build configuration checks passed."
