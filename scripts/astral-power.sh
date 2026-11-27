#!/bin/sh
set -eu
ACTION=${1:-}
STYLE=${2:-PIXEL}
case "$STYLE" in PIXEL|DOSERA|MOSAIC|FORGE|NOVA|HORIZON|AEROLITH|PRISM|LUMEN|TILESHIFT|METROVA) ;; *) echo "Unknown ASTRAL style: $STYLE" >&2; exit 2 ;; esac
case "$ACTION" in
  shutdown|poweroff)
    /usr/local/bin/astral-play-style-sound "$STYLE" shutdown
    exec systemctl poweroff
    ;;
  reboot)
    /usr/local/bin/astral-play-style-sound "$STYLE" shutdown
    exec systemctl reboot
    ;;
  logout)
    /usr/local/bin/astral-play-style-sound "$STYLE" desktop-logout
    exec openbox --exit
    ;;
  *)
    echo "Usage: astral-power.sh {shutdown|reboot|logout} [STYLE]" >&2
    exit 2
    ;;
esac
