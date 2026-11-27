# ASTRAL Linux architecture

## Principles

1. Ubuntu is the primary base for supported Classic/Modern editions.
2. Keep the graphical environment lightweight and replaceable.
3. Separate visual personalities from underlying desktop components.
4. Treat 486/Pentium-era support as a research track until boot and driver tests pass.
5. Never claim hardware compatibility without a recorded test.

## Initial build plan

- Start from a supported Ubuntu image-building workflow, selected after CI validation.
- Use a lightweight window manager and panel rather than a heavy desktop environment.
- Package ASTRAL themes, icons, wallpapers, defaults, and welcome utility separately.
- Make PIXEL the first default personality.
- Keep DOSERA, MOSAIC, FORGE, and NOVA as selectable theme/layout packages.

## Legacy track

The Legacy edition must be evaluated independently for non-PAE 32-bit kernel availability, BIOS boot, VGA framebuffer and supported graphics drivers, IDE storage, low-memory operation, and compatible userspace packages.

A current Ubuntu release must not be assumed to support 486 or non-PAE Pentium systems.
