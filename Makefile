SHELL := /bin/sh

.PHONY: check check-project check-pixel
check: check-project check-pixel

check-project:
	sh ./scripts/check-project.sh

check-pixel:
	sh ./scripts/check-pixel.sh
