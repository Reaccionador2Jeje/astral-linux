#!/bin/sh
set -eu

if [ "$(id -u)" -ne 0 ]; then
  echo "Run this installer with sudo: sudo ./scripts/install-pixel.sh" >&2
  exit 1
fi

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
PIXEL="$ROOT/desktop/pixel"

for file in "$PIXEL/openbox/rc.xml" "$PIXEL/openbox/menu.xml" "$PIXEL/tint2/tint2rc" "$PIXEL/autostart" "$PIXEL/astral-pixel.desktop" "$PIXEL/wallpaper.svg"; do
  if [ ! -s "$file" ]; then
    echo "Missing required PIXEL asset: $file" >&2
    exit 1
  fi
done

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y --no-install-recommends openbox tint2 pcmanfm lxterminal lxappearance feh fonts-dejavu-core

install -d /usr/share/astral/pixel /etc/skel/.config/openbox /etc/skel/.config/tint2
install -m 0644 "$PIXEL/wallpaper.svg" /usr/share/astral/pixel/wallpaper.svg
install -m 0644 "$PIXEL/openbox/rc.xml" /etc/skel/.config/openbox/rc.xml
install -m 0644 "$PIXEL/openbox/menu.xml" /etc/skel/.config/openbox/menu.xml
install -m 0644 "$PIXEL/tint2/tint2rc" /etc/skel/.config/tint2/tint2rc
install -m 0644 "$PIXEL/autostart" /etc/skel/.config/openbox/autostart
install -d /usr/share/xsessions
install -m 0644 "$PIXEL/astral-pixel.desktop" /usr/share/xsessions/astral-pixel.desktop

# Also configure the invoking user's home when sudo was used.
TARGET_USER=${SUDO_USER:-}
if [ -n "$TARGET_USER" ] && [ "$TARGET_USER" != root ]; then
  HOME_DIR=$(getent passwd "$TARGET_USER" | cut -d: -f6)
  if [ -n "$HOME_DIR" ] && [ -d "$HOME_DIR" ]; then
    install -d -o "$TARGET_USER" -g "$TARGET_USER" "$HOME_DIR/.config/openbox" "$HOME_DIR/.config/tint2"
    install -o "$TARGET_USER" -g "$TARGET_USER" -m 0644 "$PIXEL/openbox/rc.xml" "$HOME_DIR/.config/openbox/rc.xml"
    install -o "$TARGET_USER" -g "$TARGET_USER" -m 0644 "$PIXEL/openbox/menu.xml" "$HOME_DIR/.config/openbox/menu.xml"
    install -o "$TARGET_USER" -g "$TARGET_USER" -m 0644 "$PIXEL/tint2/tint2rc" "$HOME_DIR/.config/tint2/tint2rc"
    install -o "$TARGET_USER" -g "$TARGET_USER" -m 0644 "$PIXEL/autostart" "$HOME_DIR/.config/openbox/autostart"
  fi
fi

echo "ASTRAL PIXEL installed. Select 'ASTRAL PIXEL' at the login screen."
