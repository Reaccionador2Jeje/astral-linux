# ASTRAL graphical installer configuration

This directory contains an initial Calamares configuration and ASTRAL branding for a future live ISO.

## Current status

This is **configuration scaffolding**, not a working graphical installer yet. It must be validated against the exact Calamares version shipped in the chosen Ubuntu base, and the live image must provide the required modules and branding assets.

The partition module can modify disks. Never test an installer against a computer containing important data. Use a disposable virtual machine and a blank virtual disk first.

## Planned flow

1. Welcome and edition information.
2. Locale and keyboard selection.
3. User-reviewed partitioning.
4. User account creation.
5. Installation summary and explicit confirmation.
6. Bootloader configuration.
7. Completion and reboot.

The future ISO must boot in BIOS and UEFI modes where supported by the selected Ubuntu base. Neither this configuration nor the current command-line installers creates an ISO.
