# ASTRAL bootable ISO — experimental build

The first image target is **Ubuntu 24.04 LTS (Noble), amd64**, with a BIOS/legacy boot test target for Limbo and UEFI support intended where the selected live-build toolchain supports it.

## Build locally

On an Ubuntu/Debian amd64 build host with internet access:

```sh
sudo apt update
sudo apt install live-build xorriso squashfs-tools
sudo sh installers/iso/build-iso.sh
```

Output: `dist/astral-classic-amd64.iso` and its SHA256 file.

This is an experimental Ubuntu live-build configuration. Ubuntu support in the installed live-build version, package availability (especially Calamares), and BIOS/UEFI boot layout must be verified by CI and actual boot tests. A successful file build alone does not prove that the ISO boots or that Calamares can install.

## Limbo test target

Use Limbo's **PC (x86)** machine with an **x86_64/64-bit** CPU when available, BIOS boot, IDE CD-ROM containing the ISO, and a blank virtual hard disk for installation tests. Start with modest emulated resources (for example 2 CPU cores and 2 GB RAM); increase RAM if the live desktop fails to start. Do not attach a real disk containing personal files.

The ISO is amd64; it is not compatible with 486/Pentium 32-bit CPUs. Those require a separate Legacy image and base.

## Build gate before release

- ISO file and checksum generated.
- ISO filesystem and boot catalog validated.
- BIOS boot tested in Limbo/QEMU.
- UEFI boot tested separately.
- Live PIXEL session reaches desktop.
- Calamares starts and installs to a disposable virtual disk.
- Installed system reboots into PIXEL.

This image is not considered stable until those tests pass.
