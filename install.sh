#!/usr/bin/env bash

set -euo pipefail

# Check for the correct number of arguments
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <hostname>"
    exit 1
fi

HOST_NAME="$1"

# Constants
readonly DISK_DEVICE="/dev/nvme0n1"
readonly GITHUB_REPO="onnovalkering/configuration"
readonly DISKO_REPO="nix-community/disko"

echo "Running install script for host: ${HOST_NAME}"

# The command from your README
sudo nix run "github:${DISKO_REPO}#disko-install" \
    --experimental-features "nix-command flakes" -- \
    --flake "github:${GITHUB_REPO}#${HOST_NAME}" \
    --disk main $DISK_DEVICE \
    --write-efi-boot-entries
