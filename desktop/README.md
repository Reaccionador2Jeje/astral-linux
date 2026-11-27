# ASTRAL desktop personalities

ASTRAL personalities are selectable desktop configurations, not separate operating systems. The first five personalities establish the original classic-computing range; six additional personalities extend the visual language into the early-to-mid 2000s and touch-oriented era.

## Original five

- **PIXEL** — implemented first: Openbox session, tint2 taskbar/clock, PCManFM, LXTerminal, original wallpaper, and login sound.
- **DOSERA** — planned compact, grouped application layout.
- **MOSAIC** — planned panel-oriented workspace.
- **FORGE** — planned productivity-focused layout.
- **NOVA** — planned colorful multimedia layout.

## New six

| ASTRAL style | Era inspiration | Original design direction |
|---|---|---|
| **HORIZON** | Friendly early-2000s desktop era | Approachable blue/green palette, rounded panels, clear task grouping |
| **AEROLITH** | Experimental translucent desktop concepts | Layered depth, airy surfaces, cool highlights |
| **PRISM** | Glass-inspired desktop era | Luminous accents, subtle depth, clear window hierarchy |
| **LUMEN** | Refined late-2000s desktop era | Polished taskbar, pinned launchers, balanced spacing |
| **TILESHIFT** | Touch-first tile desktop era | Full-screen tile launcher, bold color blocks, touch-friendly navigation |
| **METROVA** | Hybrid tile-and-desktop era | Tile launcher plus conventional desktop workflow |

These names and designs are original ASTRAL identities. They are inspired by broad design eras, not copies of proprietary Windows assets or exact layouts.

## Sound themes

All eleven personalities have their own synthesized sound palette. The palettes are generated locally by `desktop/sounds/generate-sounds.py`; no Windows audio files or startup jingles are reused. See [sound themes](sounds/README.md).

## Implementation status

PIXEL is the first working desktop session. The other ten personalities are design specifications and sound profiles; they are not yet complete selectable sessions. Their implementation will follow the shared desktop framework.

PIXEL assets live in `desktop/pixel/`. Install on a compatible Ubuntu system with `sudo sh ./scripts/install-pixel.sh`; validate with `make check`.
