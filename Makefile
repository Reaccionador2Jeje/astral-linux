SHELL := /bin/sh

.PHONY: check check-project check-pixel
check: check-project check-pixel

check-project:
	./scripts/check-project.sh

check-pixel:
	./scripts/check-pixel.sh
