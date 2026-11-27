# Building ASTRAL Linux

This project is in early development; build commands will be added after the image pipeline is selected and tested.

## Development requirements

Use a supported Ubuntu build host or CI runner, keep build dependencies explicit, and produce reproducible logs and checksums.

## First milestone

1. Build a bootable Ubuntu-based live image.
2. Apply ASTRAL branding and PIXEL defaults.
3. Verify boot in a BIOS-mode virtual machine.
4. Publish the ISO only after the workflow completes successfully.
