#!/bin/sh
set -eu
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
test -s "$ROOT/installers/calamares/settings.conf"
test -s "$ROOT/installers/calamares/branding/astral/branding.desc"
test -s "$ROOT/installers/iso/README.md"
for module in welcome locale keyboard partition users summary bootloader finished; do
  grep -q "module: $module" "$ROOT/installers/calamares/settings.conf"
done
grep -q 'ASTRAL Linux' "$ROOT/installers/calamares/branding/astral/branding.desc"
echo "ASTRAL graphical-installer configuration checks passed."
