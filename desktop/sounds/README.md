# ASTRAL sound themes

ASTRAL has five original, synthesized sound palettes. They are generated locally during installation; no Windows sound files, recordings, or copyrighted startup jingles are included.

| Personality | Sound character |
|---|---|
| PIXEL | Bright, short electronic chimes |
| DOSERA | Compact, square-wave retro beeps |
| MOSAIC | Soft, rounded three-note tones |
| FORGE | Lower, restrained triangle-wave alerts |
| NOVA | Brighter, playful high-register chimes |

Each theme includes desktop login/logout, new-message, warning/error, and device connect/disconnect cues. The current PIXEL session plays its own login cue. Other personalities can call `scripts/play-style-sound.sh STYLE EVENT` when their session launchers are implemented.

Generate the themes on an Ubuntu system with:

```sh
sudo python3 desktop/sounds/generate-sounds.py
```

Example:

```sh
scripts/play-style-sound.sh PIXEL desktop-login
scripts/play-style-sound.sh NOVA message-new-instant
```

Audio playback requires a working desktop audio service and `canberra-gtk-play` (provided by `libcanberra-gtk3-module`).
