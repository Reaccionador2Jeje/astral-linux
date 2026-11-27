#!/bin/sh
set -eu
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
sh -n "$ROOT/installers/iso/build-iso.sh"
test -s "$ROOT/installers/iso/config/package-lists/astral.list.chroot"
test -s "$ROOT/installers/iso/config/includes.chroot/etc/skel/.config/openbox/autostart"
test -s "$ROOT/installers/iso/config/includes.chroot/etc/skel/.config/openbox/menu.xml"
grep -q 'Ubuntu 24.04' "$ROOT/installers/iso/README.md"
grep -q 'Limbo' "$ROOT/installers/iso/README.md"
echo "ASTRAL ISO build configuration checks passed."
