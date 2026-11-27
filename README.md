# ASTRAL Linux

**A classic-computing Linux distribution by AtDev, based on Ubuntu.**

ASTRAL targets both beige tower PCs from the late 1990s/early 2000s and modern computers. Its goal is a classic, lightweight interface with practical Linux software on hardware that the selected base can support.

## Eleven original desktop personalities

### Classic and early-computing styles
- **DOSERA** — compact, group-based application desktop.
- **PIXEL** — classic taskbar and desktop workflow.
- **MOSAIC** — panel-oriented workspace and visual file navigation.
- **FORGE** — restrained, productivity-focused desktop.
- **NOVA** — colorful multimedia-era desktop.

### Extended desktop styles
- **HORIZON** — friendly blue/green desktop with approachable panels.
- **AEROLITH** — experimental layered surfaces and translucent visual language.
- **PRISM** — luminous, glass-inspired desktop surfaces.
- **LUMEN** — polished taskbar and refined desktop workflow.
- **TILESHIFT** — touch-first, full-screen tile workspace.
- **METROVA** — hybrid tile launcher and conventional desktop.

The extended styles are inspired by broad desktop-design eras from the early-to-mid 2000s through touch-oriented interfaces. All names, sound cues, themes, and artwork are original ASTRAL designs, not copies of proprietary operating-system assets.

## Editions

- **Classic** — Ubuntu-based edition for supported late-1990s/early-2000s and low-resource PCs.
- **Modern** — Ubuntu-based edition for modern x86-64 computers.
- **Legacy** — experimental research for 486, early Pentium, non-PAE and other unsupported hardware. This may require a separately validated legacy base; it must not be presented as a current Ubuntu i386 release.

## Hardware goals

Classic PC targets include legacy BIOS/MBR, VGA-compatible graphics, IDE/PATA storage, optical drives, PS/2 input, and common PCI hardware. Modern targets include UEFI and contemporary x86-64 hardware.

Hardware compatibility is not guaranteed until tested. See [hardware compatibility](docs/hardware-compatibility.md) for the target matrix and test record format.

## Project status

Early development. PIXEL is the first implemented desktop session. The other ten personalities currently have design specifications and sound palettes; their full desktop sessions are still in development. No installable ISO is published yet.

## First milestone

Build a reproducible Ubuntu-based live image with the PIXEL personality, AtDev branding, BIOS-mode and UEFI boot testing where supported, and a basic installer path. Legacy hardware support will be developed and tested separately.

See [desktop personalities](desktop/README.md), [hardware compatibility](docs/hardware-compatibility.md), and [building](docs/building.md).
