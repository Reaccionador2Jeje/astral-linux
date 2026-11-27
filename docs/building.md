# Building and installing ASTRAL Linux

ASTRAL has two separate deliverables: installers that configure an existing Ubuntu installation, and a future bootable ISO that can install ASTRAL onto a PC. The first is implemented; the ISO pipeline is not yet implemented.

## Development requirements

- Ubuntu or Debian development host.
- Git, make, Python 3, and a POSIX shell.
- Ubuntu amd64 target with working APT repositories and internet access.

## Validate the repository

```sh
make check
```

This validates project files, PIXEL XML, shell scripts, installer entry points, and generated sound WAV files.

## Install ASTRAL Classic or Modern

Clone the repository, enter its directory, and run:

```sh
sudo sh installers/astral-installer.sh
```

Choose Classic or Modern when prompted. Or select a profile directly:

```sh
sudo sh installers/install-classic.sh
sudo sh installers/install-modern.sh
```

The installer currently supports Ubuntu amd64 and the PIXEL desktop session. It installs desktop dependencies and all eleven original ASTRAL sound themes. Classic and Modern are installation profiles with different hardware targets; RAM thresholds are advisory, not hard blocks.

The installer does not format disks, change partitions, replace Ubuntu, or install a bootloader. Review the scripts before running them on an important computer. See [installer details](../installers/README.md).

## Direct PIXEL installation

```sh
sudo sh ./scripts/install-pixel.sh
```

## Sound preview

```sh
scripts/play-style-sound.sh PIXEL startup
scripts/play-style-sound.sh PIXEL shutdown
scripts/play-style-sound.sh NOVA message-new-instant
```

All eleven sound profiles are generated locally. See [sound themes](../desktop/sounds/README.md).

## Bootable ISO milestone — not yet available

1. Select and pin a supported Ubuntu base.
2. Build a live filesystem containing PIXEL and the installer.
3. Generate BIOS and UEFI boot media where supported by the selected base.
4. Test installation in virtual machines and on representative physical PCs.
5. Publish ISO images, build logs, and checksums only after successful tests.

Do not treat the current system installers as a bootable ISO installer.
