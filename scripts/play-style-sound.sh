#!/bin/sh
set -eu
STYLE=${1:-PIXEL}
EVENT=${2:-startup}
case "$STYLE" in PIXEL|DOSERA|MOSAIC|FORGE|NOVA|HORIZON|AEROLITH|PRISM|LUMEN|TILESHIFT|METROVA) ;; *) echo "Unknown ASTRAL style: $STYLE" >&2; exit 2 ;; esac
case "$EVENT" in startup|shutdown|desktop-login|desktop-logout|message-new-instant|dialog-warning|dialog-error|device-added|device-removed) ;; *) echo "Unsupported sound event: $EVENT" >&2; exit 2 ;; esac
SOUND="/usr/share/sounds/ASTRAL-$STYLE/stereo/$EVENT.wav"
if [ ! -r "$SOUND" ]; then
  echo "Sound not installed: $SOUND" >&2
  exit 1
fi
if command -v canberra-gtk-play >/dev/null 2>&1; then
  exec canberra-gtk-play --file="$SOUND"
fi
echo "canberra-gtk-play is not installed; install libcanberra-gtk3-module." >&2
exit 1
