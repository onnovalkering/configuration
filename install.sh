#!/usr/bin/env bash

set -euo pipefail

select_server() {
    local servers=("server-vesta" "server-vulcan")
    local choice

    while true; do
        echo "Please select a server:"
        for i in "${!servers[@]}"; do
            echo "$((i+1))) ${servers[$i]}"
        done
        echo ""
        read -r -p "Enter your choice (1-${#servers[@]}): " choice

        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#servers[@]}" ]; then
            HOST_NAME="${servers[$((choice-1))]}"
            break
        else
            echo "Invalid choice. Please try again."
            echo ""
        fi
    done
}
s
if [ "$#" -eq 1 ]; then
    HOST_NAME="$1"
else
    select_server
fi

readonly DISK_DEVICE="/dev/nvme0n1"
readonly GITHUB_REPO="onnovalkering/configuration"
readonly DISKO_REPO="nix-community/disko"

sudo nix run "github:${DISKO_REPO}#disko-install" \
    --experimental-features "nix-command flakes" -- \
    --flake "github:${GITHUB_REPO}#${HOST_NAME}" \
    --disk main $DISK_DEVICE \
    --write-efi-boot-entries
