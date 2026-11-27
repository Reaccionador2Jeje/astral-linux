# ASTRAL installers

These scripts install the first ASTRAL desktop session on an existing Ubuntu amd64 installation. They do **not** partition disks, replace Ubuntu, or create a bootable installer ISO.

## Quick start

From a clone of this repository:

```sh
sudo sh installers/astral-installer.sh
```

Choose Classic or Modern interactively. Or select a profile directly:

```sh
sudo sh installers/install-classic.sh
sudo sh installers/install-modern.sh
```

PIXEL is the only installable session in this milestone. The other ten personalities are documented designs and sound themes, not yet complete desktop sessions.

## Requirements and behavior

- Ubuntu amd64 with working APT repositories.
- Administrator privileges.
- Internet connection to install Ubuntu packages.
- Classic is intended for lower-resource compatible PCs; Modern is intended for newer PCs.
- RAM recommendations are advisory only; the installer warns rather than blocking.
- The installer delegates desktop setup to `scripts/install-pixel.sh`.
- It does not format disks, edit partitions, install a bootloader, or overwrite the existing operating system.

The experimental Legacy target for 32-bit 486/Pentium hardware is not supported by this installer.

## ISO installer milestone

A separate live-ISO build and graphical disk installer will be developed and tested before any bootable ISO is advertised.
