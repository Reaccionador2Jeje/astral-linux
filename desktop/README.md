# ASTRAL desktop personalities

ASTRAL personalities are selectable desktop configurations, not separate operating systems.

- **PIXEL** — first implementation: Openbox session, tint2 taskbar/clock, PCManFM file manager, LXTerminal, classic keyboard shortcuts, original ASTRAL wallpaper, and its own login sound.
- **DOSERA** — planned compact, grouped application layout.
- **MOSAIC** — planned panel-oriented workspace.
- **FORGE** — planned productivity-focused layout.
- **NOVA** — planned colorful multimedia layout.

Each personality has an original sound palette. The five palettes are synthesized locally by `desktop/sounds/generate-sounds.py`; they do not reuse Windows system audio. See [sound themes](sounds/README.md).

PIXEL assets live in `desktop/pixel/`. Install on a compatible Ubuntu system with `sudo sh ./scripts/install-pixel.sh`; validate with `make check`.
