#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)
OUT_DIR=${ASTRAL_OUT_DIR:-/home/eggs}
EGGS_API=https://api.github.com/repos/pieroproietti/penguins-eggs/releases/latest
EGGS_ASSET=penguins-eggs-debian.zip
ARCH=${ASTRAL_ARCH:-amd64}
CODENAME=${ASTRAL_UBUNTU_CODENAME:-noble}

if [ "$(id -u)" -ne 0 ]; then
  echo "This build must run as root inside the isolated Ubuntu builder." >&2
  exit 1
fi
[ "$ARCH" = amd64 ] || { echo "Only amd64 is supported." >&2; exit 2; }
[ "$CODENAME" = noble ] || { echo "Only Ubuntu 24.04 Noble is configured." >&2; exit 2; }
[ -s /etc/os-release ] || { echo "Cannot identify the build system." >&2; exit 1; }
. /etc/os-release
[ "${ID:-}" = ubuntu ] || { echo "Expected Ubuntu; found ${ID:-unknown}." >&2; exit 2; }
case "${VERSION_ID:-}" in 24.04) ;; *) echo "Expected Ubuntu 24.04; found ${VERSION_ID:-unknown}." >&2; exit 2 ;; esac
[ "$(dpkg --print-architecture)" = amd64 ] || { echo "Builder architecture must be amd64." >&2; exit 2; }

export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a
export TERM=${TERM:-xterm}

echo "[ASTRAL] Installing base build dependencies..."
apt-get update
apt-get install -y --no-install-recommends \
  ca-certificates curl jq unzip xorriso squashfs-tools rsync \
  linux-image-generic systemd-sysv

PACKAGES=$(awk '!/^[[:space:]]*(#|$)/ { print }' "$ROOT/installers/iso/config/package-lists/astral.list.chroot")
# Intentional word splitting: the package list contains one apt package per line.
# shellcheck disable=SC2086
apt-get install -y --no-install-recommends $PACKAGES

echo "[ASTRAL] Installing the ASTRAL PIXEL desktop and sound assets..."
sh "$ROOT/scripts/install-pixel.sh"

echo "[ASTRAL] Downloading the official Penguins' Eggs Debian package..."
EGGS_TMP=$(mktemp -d /tmp/astral-eggs.XXXXXX)
RELEASE_JSON="$EGGS_TMP/release.json"
curl --fail --silent --show-error --location "$EGGS_API" -o "$RELEASE_JSON"
EGGS_URL=$(jq -er --arg name "$EGGS_ASSET" '.assets[] | select(.name == $name) | .browser_download_url' "$RELEASE_JSON")
EGGS_DIGEST=$(jq -er --arg name "$EGGS_ASSET" '.assets[] | select(.name == $name) | .digest | sub("^sha256:"; "")' "$RELEASE_JSON")
curl --fail --silent --show-error --location "$EGGS_URL" -o "$EGGS_TMP/$EGGS_ASSET"
printf '%s  %s\n' "$EGGS_DIGEST" "$EGGS_TMP/$EGGS_ASSET" | sha256sum --check --status

mkdir -p "$EGGS_TMP/unpacked"
unzip -q "$EGGS_TMP/$EGGS_ASSET" -d "$EGGS_TMP/unpacked"
set --
while IFS= read -r -d '' package; do
  set -- "$@" "$package"
done <<EOF
$(find "$EGGS_TMP/unpacked" -type f -name '*.deb' -print0)
EOF
[ "$#" -gt 0 ] || {
  echo "The official Penguins' Eggs Debian archive did not contain any .deb packages." >&2
  find "$EGGS_TMP/unpacked" -maxdepth 3 -type f -print >&2
  exit 1
}
dpkg -i "$@" || apt-get install -f -y
command -v eggs >/dev/null 2>&1 || { echo "Penguins' Eggs did not install an eggs command." >&2; exit 1; }
eggs version

echo "[ASTRAL] Preparing the live desktop..."
install -d /etc/lightdm/lightdm.conf.d /usr/share/astral
cat > /etc/lightdm/lightdm.conf.d/50-astral-pixel.conf <<'EOF'
[Seat:*]
greeter-session=lightdm-gtk-greeter
user-session=astral-pixel
EOF
if command -v systemctl >/dev/null 2>&1; then
  systemctl --root=/ set-default graphical.target
  systemctl --root=/ enable lightdm.service
  systemctl --root=/ enable NetworkManager.service
fi
sed -i \
  -e 's/^NAME=.*/NAME="ASTRAL Linux"/' \
  -e 's/^PRETTY_NAME=.*/PRETTY_NAME="ASTRAL Linux Classic"/' \
  /etc/os-release
printf 'ASTRAL Linux Classic\\n' > /etc/issue
printf 'astral\\n' > /etc/hostname

echo "[ASTRAL] Removing build-only files before remastering..."
rm -rf "$EGGS_TMP"
rm -rf /var/lib/apt/lists/*
apt-get clean
rm -rf /tmp/astral-source /root/.cache /root/.npm /root/.local/share/Trash
mkdir -p "$OUT_DIR"
rm -f "$OUT_DIR"/*.iso "$OUT_DIR"/*.sha256

echo "[ASTRAL] Creating a standard, redistributable Live ISO with Penguins' Eggs..."
cd /
eggs tools repo add
eggs remaster

ISO=$(find "$OUT_DIR" -maxdepth 1 -type f -name '*.iso' ! -name 'astral-classic-amd64.iso' -print -quit)
[ -n "$ISO" ] || {
  echo "Penguins' Eggs completed without an ISO in $OUT_DIR." >&2
  find /home/eggs /var/lib -maxdepth 3 -type f -name '*.iso' -print 2>/dev/null >&2 || true
  exit 1
}
if [ "$ISO" != "$OUT_DIR/astral-classic-amd64.iso" ]; then
  mv "$ISO" "$OUT_DIR/astral-classic-amd64.iso"
fi
(cd "$OUT_DIR" && sha256sum astral-classic-amd64.iso > astral-classic-amd64.iso.sha256)
echo "[ASTRAL] ISO created: $OUT_DIR/astral-classic-amd64.iso"
