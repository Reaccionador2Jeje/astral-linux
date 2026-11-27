# ASTRAL sound themes

All eleven ASTRAL desktop personalities have original synthesized sound palettes. No Windows sound files, recordings, or copyrighted startup jingles are included.

| Personality | Sound character |
|---|---|
| PIXEL | Bright, short electronic chimes |
| DOSERA | Compact, square-wave retro beeps |
| MOSAIC | Soft, rounded three-note tones |
| FORGE | Lower, restrained triangle-wave alerts |
| NOVA | Bright, playful high-register chimes |
| HORIZON | Warm, friendly ascending chimes |
| AEROLITH | Airy, bell-like synthesized notes |
| PRISM | Shimmering multi-note cues |
| LUMEN | Polished ascending signals |
| TILESHIFT | Short, rhythmic electronic tones |
| METROVA | Balanced hybrid melody |

Each theme includes desktop login/logout, new-message, warning/error, and device connect/disconnect cues. The current PIXEL session plays its own login cue. Other personalities can call `scripts/play-style-sound.sh STYLE EVENT` as their desktop sessions are implemented.

Generate the themes on an Ubuntu system with:

```sh
sudo python3 desktop/sounds/generate-sounds.py
```

Example:

```sh
scripts/play-style-sound.sh PIXEL desktop-login
scripts/play-style-sound.sh HORIZON device-added
scripts/play-style-sound.sh TILESHIFT dialog-warning
```

Available styles: PIXEL, DOSERA, MOSAIC, FORGE, NOVA, HORIZON, AEROLITH, PRISM, LUMEN, TILESHIFT, METROVA.

Audio playback requires a working desktop audio service and `canberra-gtk-play` (provided by `libcanberra-gtk3-module`).
