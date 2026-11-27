# Building ASTRAL Linux

ASTRAL is being developed in verifiable milestones. The PIXEL desktop assets can now be validated and installed on an existing Ubuntu system; the bootable ISO pipeline is a separate milestone and is not yet implemented.

## Development requirements

- Ubuntu or Debian development host.
- Git, make, Python 3, and a POSIX shell.
- For a PIXEL test machine, an Ubuntu installation with access to its package repositories.

## Validate the repository

```sh
make check
```

This checks required project files, PIXEL assets, shell syntax, and the Openbox XML configuration.

## Install PIXEL on an existing Ubuntu installation

```sh
sudo sh ./scripts/install-pixel.sh
```

The installer installs Openbox, tint2, PCManFM, LXTerminal, LXAppearance, and the wallpaper utility; installs the ASTRAL PIXEL session entry; and seeds the default configuration for new users and the invoking user. Select **ASTRAL PIXEL** from the display manager's session chooser, then sign in.

This modifies the selected Ubuntu installation. Review the script before running it on an important machine.

## ISO milestone (not yet available)

1. Select and pin a supported Ubuntu base.
2. Build a live filesystem with PIXEL and an installer path.
3. Generate BIOS and UEFI boot media where supported by the selected base.
4. Test the ISO in virtual machines and on physical hardware.
5. Publish the ISO, build logs, and checksums only after successful tests.
