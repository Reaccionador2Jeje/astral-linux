# ASTRAL bootable ISO — Penguins' Eggs VM build

The first image target is **Ubuntu 24.04 LTS (Noble), amd64**. The ISO is intended for BIOS/legacy boot testing in Limbo and UEFI testing on compatible x86-64 systems.

ASTRAL uses [Penguins' Eggs](https://github.com/pieroproietti/penguins-eggs) to remaster the prepared Ubuntu system into a hybrid Live ISO.

## Why this uses a dedicated VM

Penguins' Eggs performs real filesystem and kernel mount operations while remastering the running operating system. The previous GitHub Actions Docker build reached `eggs remaster` but failed when OverlayFS could not be mounted inside the container. Running the same command in another container is not a fix.

The workflow therefore requires a **dedicated, disposable Ubuntu 24.04 amd64 virtual machine** registered as a self-hosted GitHub Actions runner with these labels:

- `self-hosted`
- `linux`
- `x64`
- `astral-eggs-vm`

The VM should have at least 4 vCPUs, 8 GB RAM, and 60 GB free disk space. It must have a normal non-OverlayFS root filesystem, working systemd/mount support, internet access, and passwordless sudo for the runner account.

Before registering the runner, provision the VM from a clean Ubuntu 24.04 amd64 installation and create the explicit safety marker:

```sh
sudo install -m 0644 /dev/null /etc/astral-ephemeral-builder
```

The marker does not make a machine disposable by itself. The VM must be isolated from personal files and reset to its clean snapshot after each run, because Eggs remasters the live operating system and the build installs packages onto it.

Do not register a personal workstation, shared server, or machine containing data that must not be included in a distributable image. Keep the runner offline except while building, and do not run untrusted pull-request code on it.

## Run the build

Open **Actions → ASTRAL ISO build → Run workflow**. The workflow runs only on the dedicated VM runner. It does not fall back to GitHub-hosted containers.

The script installs the ASTRAL packages and PIXEL session, downloads the official Penguins' Eggs Debian release archive, checks its published SHA-256 digest, then runs:

```sh
eggs tools repo add
eggs remaster
```

The resulting ISO and checksum are uploaded as the `astral-classic-amd64-iso` workflow artifact after file, El Torito, and SHA-256 checks.

Workflow: [ASTRAL ISO build](../../.github/workflows/iso-build.yml).

## Local build safety

The build script intentionally refuses to run unless all of these are true:

- It is running as root on Ubuntu 24.04 amd64.
- `/etc/astral-ephemeral-builder` exists.
- The root filesystem is not OverlayFS.

These checks prevent accidental remastering inside Docker or on an ordinary personal computer. Do not bypass them.

## Current scope and release gate

- The initial target is amd64 only; this ISO does not support 486/Pentium 32-bit processors.
- PIXEL is the first desktop session installed in this image.
- The other ten ASTRAL personalities are not yet complete desktop sessions.
- Calamares is included as a package, but its configuration and end-to-end installation flow remain experimental.
- A successful ISO build does not prove that the image boots or installs correctly.

Before calling the ISO stable:

- ISO file and SHA256 generated.
- ISO filesystem and El Torito boot catalog validated.
- BIOS boot tested in Limbo/QEMU.
- UEFI boot tested separately.
- Live PIXEL session reaches the desktop.
- Installer starts and installs to a disposable virtual disk.
- Installed system reboots into PIXEL.

## Limbo test target

Use Limbo's **PC (x86)** machine with an **x86_64/64-bit** CPU when available, BIOS boot, IDE CD-ROM containing the ISO, and a blank virtual hard disk for installation tests. Start with 2 CPU cores and 2 GB RAM; increase RAM if the live desktop fails to start. Never attach a real disk containing personal files.
