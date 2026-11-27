#!/bin/sh
set -eu
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)
OUT_DIR=${ASTRAL_OUT_DIR:-"$ROOT/dist"}
WORK_DIR=${ASTRAL_WORK_DIR:-"$ROOT/.build/live"}
ARCH=${ASTRAL_ARCH:-amd64}
CODENAME=${ASTRAL_UBUNTU_CODENAME:-noble}

if [ "$(id -u)" -ne 0 ]; then
  echo "Run as root: sudo sh installers/iso/build-iso.sh" >&2
  exit 1
fi
[ "$ARCH" = amd64 ] || { echo "Only amd64 is supported." >&2; exit 2; }
[ "$CODENAME" = noble ] || { echo "Only Ubuntu noble is configured." >&2; exit 2; }
for cmd in lb xorriso mksquashfs; do
  command -v "$cmd" >/dev/null 2>&1 || { echo "Missing build dependency: $cmd" >&2; exit 1; }
done

mkdir -p "$OUT_DIR" "$(dirname "$WORK_DIR")"
rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR"
cp -R "$ROOT/installers/iso/config" "$WORK_DIR/config"
cd "$WORK_DIR"

lb config \
  --mode ubuntu \
  --distribution "$CODENAME" \
  --architectures "$ARCH" \
  --archive-areas "main universe multiverse" \
  --binary-images iso-hybrid \
  --bootloaders "grub-efi,syslinux" \
  --debian-installer false \
  --apt-recommends true \
  --iso-application "ASTRAL Linux" \
  --iso-publisher "AtDev" \
  --iso-volume "ASTRAL_CLASSIC" \
  --image-name "astral-classic"

lb build
ISO=$(find "$WORK_DIR" -maxdepth 1 -type f -name '*.iso' -print -quit)
[ -n "$ISO" ] || { echo "No ISO was produced." >&2; exit 1; }
mkdir -p "$OUT_DIR"
cp "$ISO" "$OUT_DIR/astral-classic-amd64.iso"
(cd "$OUT_DIR" && sha256sum astral-classic-amd64.iso > astral-classic-amd64.iso.sha256)
echo "ISO created: $OUT_DIR/astral-classic-amd64.iso"
