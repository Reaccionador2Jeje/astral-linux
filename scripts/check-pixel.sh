#!/bin/sh
set -eu
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
PIXEL="$ROOT/desktop/pixel"
for file in openbox/rc.xml openbox/menu.xml tint2/tint2rc autostart astral-pixel.desktop wallpaper.svg; do
  test -s "$PIXEL/$file" || { echo "Missing PIXEL asset: $file" >&2; exit 1; }
done
test -s "$ROOT/desktop/sounds/generate-sounds.py"
test -s "$ROOT/scripts/play-style-sound.sh"

if command -v python3 >/dev/null 2>&1; then
  python3 - "$PIXEL/openbox/rc.xml" "$PIXEL/openbox/menu.xml" <<'PY'
import sys
import xml.etree.ElementTree as ET
for path in sys.argv[1:]:
    ET.parse(path)
print("PIXEL XML: valid")
PY
  SOUND_TMP=$(mktemp -d)
  trap 'rm -rf "$SOUND_TMP"' EXIT HUP INT TERM
  ASTRAL_SOUND_ROOT="$SOUND_TMP" python3 "$ROOT/desktop/sounds/generate-sounds.py"
  python3 - "$SOUND_TMP" <<'PY'
import os, sys, wave
root = sys.argv[1]
styles = ("PIXEL", "DOSERA", "MOSAIC", "FORGE", "NOVA", "HORIZON", "AEROLITH", "PRISM", "LUMEN", "TILESHIFT", "METROVA")
events = ("desktop-login", "desktop-logout", "message-new-instant",
          "dialog-warning", "dialog-error", "device-added", "device-removed")
for style in styles:
    base = os.path.join(root, "ASTRAL-" + style, "stereo")
    for event in events:
        path = os.path.join(base, event + ".wav")
        with wave.open(path, "rb") as audio:
            assert audio.getnchannels() == 1 and audio.getframerate() == 22050
            assert audio.getnframes() > 0
print("ASTRAL sound themes: valid (11 styles, 7 events each)")
PY
fi
sh -n "$ROOT/scripts/install-pixel.sh"
sh -n "$ROOT/scripts/play-style-sound.sh"
echo "ASTRAL PIXEL assets: OK"
