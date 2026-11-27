#!/bin/sh
set -eu
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
PIXEL="$ROOT/desktop/pixel"
for file in openbox/rc.xml openbox/menu.xml tint2/tint2rc autostart astral-pixel.desktop wallpaper.svg; do
  test -s "$PIXEL/$file" || { echo "Missing PIXEL asset: $file" >&2; exit 1; }
done
if command -v python3 >/dev/null 2>&1; then
  python3 - "$PIXEL/openbox/rc.xml" "$PIXEL/openbox/menu.xml" <<'PY'
import sys
import xml.etree.ElementTree as ET
for path in sys.argv[1:]:
    ET.parse(path)
print("PIXEL XML: valid")
PY
fi
sh -n "$ROOT/scripts/install-pixel.sh"
echo "ASTRAL PIXEL assets: OK"
