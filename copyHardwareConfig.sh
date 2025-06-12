#!/usr/bin/env bash

set -euo pipefail

SOURCE="/etc/nixos/hardware-configuration.nix"
DEST="./hardware-configuration.nix"

if [ -f "$SOURCE" ]; then
    cp -f "$SOURCE" "$DEST"
    echo "Copied $SOURCE to $DEST"
else
    echo "Error: $SOURCE does not exist." >&2
    exit 1
fi

