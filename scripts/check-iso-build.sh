#!/bin/sh
set -eu
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
WORKFLOW="$ROOT/.github/workflows/iso-build.yml"
BUILD="$ROOT/installers/iso/build-iso.sh"
README="$ROOT/installers/iso/README.md"

sh -n "$BUILD"
test -s "$ROOT/installers/iso/config/package-lists/astral.list.chroot"
test -s "$ROOT/desktop/pixel/astral-pixel.desktop"
test -s "$ROOT/desktop/pixel/openbox/rc.xml"
test -s "$ROOT/desktop/pixel/tint2/tint2rc"
grep -q 'Penguins' "$README"
grep -q 'eggs remaster' "$README"
grep -q 'self-hosted' "$WORKFLOW"
grep -q 'astral-eggs-vm' "$WORKFLOW"
grep -q '/etc/astral-ephemeral-builder' "$WORKFLOW"
grep -q 'findmnt -n -o FSTYPE /' "$BUILD"
grep -q '/etc/astral-ephemeral-builder' "$BUILD"

if grep -n -E 'docker (create|run|exec)|runs-on: ubuntu-' "$WORKFLOW"; then
  echo "The active Eggs remaster workflow must not use a container or hosted runner." >&2
  exit 1
fi
if grep -R -n -E '(^|[[:space:]])lb (config|build)|live-build' "$BUILD" "$WORKFLOW"; then
  echo "Live-Build references remain in the active ISO pipeline." >&2
  exit 1
fi
echo "ASTRAL Penguins' Eggs dedicated-VM ISO configuration checks passed."
