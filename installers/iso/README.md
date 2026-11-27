# ASTRAL bootable ISO

The bootable ISO is a separate milestone from the existing-OS installers.

## Planned image contents

- Ubuntu-supported amd64 live base.
- PIXEL desktop session and ASTRAL sound profiles.
- Calamares graphical installer, after compatibility validation.
- BIOS and UEFI boot support where the selected Ubuntu base supports them.
- A live session that can be tested without installing.

## Build gate

Do not publish an ISO until all of these are true:

- Image builds reproducibly in CI.
- ISO passes file and boot-catalog validation.
- BIOS and UEFI boot tests pass in virtual machines.
- Installer can complete against a disposable blank virtual disk.
- Installed system boots and starts PIXEL.
- SHA256 checksum and build manifest are published.

At present, no bootable ASTRAL ISO is produced by this repository.
