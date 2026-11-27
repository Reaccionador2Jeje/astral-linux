# ASTRAL Linux

**A classic-computing Linux distribution by AtDev, based on Ubuntu.**

ASTRAL targets beige tower PCs from the late 1990s/early 2000s and modern computers. Its goal is a classic, lightweight interface with practical Linux software on hardware supported by the selected Ubuntu base.

## Eleven original desktop personalities

- **DOSERA** — compact, group-based application desktop.
- **PIXEL** — classic taskbar and desktop workflow; first implemented session.
- **MOSAIC** — panel-oriented workspace and visual file navigation.
- **FORGE** — restrained, productivity-focused desktop.
- **NOVA** — colorful multimedia-era desktop.
- **HORIZON** — friendly blue/green desktop.
- **AEROLITH** — layered surfaces and translucent visual language.
- **PRISM** — luminous, glass-inspired surfaces.
- **LUMEN** — polished taskbar and refined workflow.
- **TILESHIFT** — touch-first, full-screen tile workspace.
- **METROVA** — hybrid tile launcher and conventional desktop.

All names, sound cues, themes, and artwork are original ASTRAL designs.

## Editions and installers

- **Classic** — intended for lower-resource compatible Ubuntu amd64 PCs.
- **Modern** — intended for newer Ubuntu amd64 PCs.
- **Legacy** — experimental research for 486, early Pentium, non-PAE and other unsupported hardware; not currently installable.

The repository includes command-line installers for Classic and Modern. They install the PIXEL desktop onto an existing Ubuntu amd64 installation. They do not partition disks, replace the existing OS, or create bootable media.

```sh
sudo sh installers/astral-installer.sh
sudo sh installers/install-classic.sh
sudo sh installers/install-modern.sh
```

Only PIXEL is currently an installable desktop session. The other ten personalities have design specifications and sound palettes, but their complete sessions are still in development.

## Hardware goals

Classic PC targets include legacy BIOS/MBR, VGA-compatible graphics, IDE/PATA storage, optical drives, PS/2 input, and common PCI hardware. Modern targets include UEFI and contemporary x86-64 hardware. Compatibility is not guaranteed until tested.

## Project status

Early development. The Classic/Modern system installers are available for existing Ubuntu amd64 installations. Initial Calamares configuration and ASTRAL branding have been added for the future graphical installer, but they are scaffolding only. A bootable ASTRAL ISO with a tested graphical disk installer is **not yet available**. Legacy 32-bit support is separate research.

See [installers](installers/README.md), [desktop personalities](desktop/README.md), [hardware compatibility](docs/hardware-compatibility.md), and [building](docs/building.md).
