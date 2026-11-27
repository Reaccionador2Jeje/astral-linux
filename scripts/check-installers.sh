#!/bin/sh
set -eu
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
for script in "$ROOT/installers/astral-installer.sh" "$ROOT/installers/install-classic.sh" "$ROOT/installers/install-modern.sh"; do
  sh -n "$script"
done
grep -q 'install-pixel.sh' "$ROOT/installers/astral-installer.sh"
grep -q 'PROFILE=classic' "$ROOT/installers/astral-installer.sh"
grep -q 'PROFILE=modern' "$ROOT/installers/astral-installer.sh"
echo "ASTRAL installer shell checks passed."
