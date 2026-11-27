# ASTRAL bootable ISO — experimental Penguins' Eggs build

The first image target is **Ubuntu 24.04 LTS (Noble), amd64**. The ISO is intended for BIOS/legacy boot testing in Limbo and UEFI testing on compatible x86-64 systems.

ASTRAL no longer uses Live-Build. The build pipeline uses [Penguins' Eggs](https://github.com/pieroproietti/penguins-eggs), which remasters a prepared Ubuntu system into a hybrid Live ISO. Its upstream quick start documents `eggs remaster`, the standard live-image workflow, and BIOS + UEFI output.

## Automated build

GitHub Actions runs a disposable, privileged Ubuntu 24.04 Docker builder. The repository is copied into that isolated environment; the build script installs the ASTRAL packages and PIXEL session, installs the official Penguins' Eggs Debian package from its GitHub release, and runs:

```sh
eggs tools repo add
eggs remaster
```

The release archive is downloaded from the official Penguins' Eggs GitHub Releases API and its published SHA-256 digest is checked before installation. The builder container is removed at the end of the workflow.

Workflow: [ASTRAL ISO build](../../.github/workflows/iso-build.yml).

## Build locally

For a disposable Ubuntu 24.04 amd64 machine with internet access, Docker, and enough free disk space:

```sh
docker pull ubuntu:24.04
docker create --privileged --name astral-eggs-builder ubuntu:24.04 sleep infinity
docker start astral-eggs-builder
docker cp . astral-eggs-builder:/tmp/astral-source
docker exec astral-eggs-builder bash /tmp/astral-source/installers/iso/build-iso.sh
docker cp astral-eggs-builder:/home/eggs/astral-classic-amd64.iso dist/
docker cp astral-eggs-builder:/home/eggs/astral-classic-amd64.iso.sha256 dist/
docker rm -f astral-eggs-builder
```

Output: `dist/astral-classic-amd64.iso` and its SHA256 file.

The build runs in a disposable container because Eggs remasters the running system. Do not run this process on a personal workstation or a system containing files that must not be included in a distributable image.

## Important scope

- The initial target is amd64 only; this ISO does not support 486/Pentium 32-bit processors.
- PIXEL is the first desktop session installed in this image.
- The other ten ASTRAL personalities are not yet complete desktop sessions.
- Calamares is included as a package, but its configuration and end-to-end installation flow remain experimental.
- A successful ISO build does not prove that the image boots or installs correctly.

## Limbo test target

Use Limbo's **PC (x86)** machine with an **x86_64/64-bit** CPU when available, BIOS boot, IDE CD-ROM containing the ISO, and a blank virtual hard disk for installation tests. Start with 2 CPU cores and 2 GB RAM; increase RAM if the live desktop fails to start. Do not attach a real disk containing personal files.

## Build gate before release

- ISO file and SHA256 generated.
- ISO filesystem and El Torito boot catalog validated.
- BIOS boot tested in Limbo/QEMU.
- UEFI boot tested separately.
- Live PIXEL session reaches the desktop.
- Installer starts and installs to a disposable virtual disk.
- Installed system reboots into PIXEL.

This image is not considered stable until those tests pass.
