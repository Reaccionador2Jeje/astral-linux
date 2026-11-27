# ASTRAL sound themes

All eleven ASTRAL desktop personalities have original synthesized sound palettes. Every personality has dedicated **startup** and **shutdown** cues, as well as optional desktop logout, message, warning, error, and device events. No Windows sound files, recordings, or copyrighted startup jingles are included.

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

## Generate and preview

```sh
sudo python3 desktop/sounds/generate-sounds.py
scripts/play-style-sound.sh PIXEL startup
scripts/play-style-sound.sh PIXEL shutdown
scripts/play-style-sound.sh HORIZON startup
scripts/play-style-sound.sh TILESHIFT shutdown
```

Supported styles: PIXEL, DOSERA, MOSAIC, FORGE, NOVA, HORIZON, AEROLITH, PRISM, LUMEN, TILESHIFT, METROVA.

## Power actions

The PIXEL menu offers **Log Out**, **Restart**, and **Shut Down** with sound. Restart and shutdown play the selected style's shutdown cue before asking systemd to perform the action. The generic `scripts/astral-power.sh` command accepts an action and a style name, so the other desktop sessions can reuse it.

Example: `astral-power.sh shutdown AEROLITH`.

A shutdown cue is guaranteed when power-off/restart is initiated through the ASTRAL power menu. Physical power-button handling and shutdown initiated by external desktop managers need separate integration with those environments.

Audio playback requires a working desktop audio service and `canberra-gtk-play` (provided by `libcanberra-gtk3-module`).
