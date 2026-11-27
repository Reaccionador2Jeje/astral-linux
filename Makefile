SHELL := /bin/sh

.PHONY: check check-project check-pixel check-installers check-graphical-installer check-iso
check: check-project check-pixel check-installers check-graphical-installer check-iso

check-project:
	sh ./scripts/check-project.sh

check-pixel:
	sh ./scripts/check-pixel.sh

check-installers:
	sh ./scripts/check-installers.sh

check-graphical-installer:
	sh ./scripts/check-graphical-installer.sh

check-iso:
	sh ./scripts/check-iso-build.sh
