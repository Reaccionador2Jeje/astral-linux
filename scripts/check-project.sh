#!/bin/sh
set -eu

required_files="
README.md
docs/architecture.md
docs/hardware-compatibility.md
docs/building.md
desktop/README.md
editions/README.md
tools/README.md
"

for file in $required_files; do
    if [ ! -s "$file" ]; then
        echo "ERROR: missing or empty project file: $file" >&2
        exit 1
    fi
done

echo "ASTRAL Linux project structure: OK"
