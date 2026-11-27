# Building ASTRAL Linux

ASTRAL is being developed in verifiable milestones. The PIXEL desktop and original sound themes can now be installed on an existing Ubuntu system; the bootable ISO pipeline is a separate milestone and is not yet implemented.

## Development requirements

- Ubuntu or Debian development host.
- Git, make, Python 3, and a POSIX shell.
- For a PIXEL test machine, an Ubuntu installation with access to its package repositories and a working audio service.

## Validate the repository

```sh
make check
```

This checks required project files, PIXEL XML, shell syntax, and generates all five sound themes in a temporary directory to validate their WAV files.

## Install PIXEL on an existing Ubuntu installation

```sh
sudo sh ./scripts/install-pixel.sh
```

The installer installs Openbox, tint2, PCManFM, LXTerminal, LXAppearance, feh, Python 3, and the Canberra GTK sound player; generates all eleven original ASTRAL sound themes, each with dedicated startup and shutdown cues; installs the ASTRAL PIXEL session entry; and seeds the default desktop configuration for new users and the invoking user. Select **ASTRAL PIXEL** from the display manager's session chooser, then sign in. PIXEL plays its original startup cue at login. Its power menu plays the shutdown cue before restart or power-off.

This modifies the selected Ubuntu installation. Review the script before running it on an important machine.

Startup and shutdown cues can be previewed with:

```sh
scripts/play-style-sound.sh PIXEL startup
scripts/play-style-sound.sh PIXEL shutdown
scripts/play-style-sound.sh NOVA message-new-instant
```

Available styles: PIXEL, DOSERA, MOSAIC, FORGE, NOVA. See [sound themes](../desktop/sounds/README.md).

## ISO milestone (not yet available)

1. Select and pin a supported Ubuntu base.
2. Build a live filesystem with PIXEL and an installer path.
3. Generate BIOS and UEFI boot media where supported by the selected base.
4. Test the ISO in virtual machines and on physical hardware.
5. Publish the ISO, build logs, and checksums only after successful tests.
