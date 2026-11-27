# Hardware compatibility

ASTRAL targets both classic beige desktop PCs (late 1990s/early 2000s) and modern computers. The reference class includes a tower PC with legacy BIOS, CRT/VGA display, IDE optical drive, and classic keyboard/mouse.

Compatibility is a goal, not yet a verified guarantee. Hardware support will be reported only after testing.

## Target matrix

| Target class | Intended experience | Planned path | Status |
|---|---|---|---|
| 486 / early Pentium | Minimal retro environment | Separate Legacy research base | Research; not current Ubuntu-supported |
| Pentium / Pentium MMX | Lightweight classic desktop if resources permit | Legacy research | Research |
| Pentium II / III | Classic desktop and era-appropriate applications | Legacy research | Research |
| Late-1990s / early-2000s x86 PC | ASTRAL classic desktop with PIXEL and other personalities | Ubuntu-based image where CPU/RAM/kernel support allow; otherwise Legacy | Planned |
| Modern x86-64 PC | Full ASTRAL experience, themes and contemporary applications | Supported Ubuntu base | Planned |

## Compatibility notes

- BIOS/MBR boot is a target for classic PCs; UEFI support is required for modern systems.
- VGA-compatible display, IDE/PATA storage, optical drives, PS/2 keyboard/mouse, and common PCI hardware are important test cases.
- A CRT is a display device; actual compatibility depends on the graphics adapter and supported video modes.
- Ubuntu's current releases do not provide a complete modern i386 installation stack. Do not promise that a 486, non-PAE Pentium, or every 32-bit PC can run the Ubuntu-based edition.
- The five ASTRAL desktop personalities are interface configurations, not separate operating systems. They may be offered wherever the underlying desktop and hardware are supported.

## Test record

For every physical test, record:
- machine/model and CPU;
- RAM;
- graphics adapter and monitor connection;
- storage controller and boot media;
- BIOS/UEFI mode;
- whether it reaches live desktop and installer;
- network, sound, and input status;
- result and known limitations.

Do not mark a device supported based only on a successful virtual-machine boot. Distinguish physical-hardware results from QEMU/VM results.
