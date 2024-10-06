# Configuration
This repository contains my configurations, most of it relies on Nix.

# Installation

## NixOS
Boot into the live environment and run the following command:

```
$ export HOST_NAME="nixos"
$ export DISK_NAME="/dev/nvme0n1"
$ sudo nix run "github:nix-community/disko#disko-install" \
    --experimental-features "nix-command flakes" -- \
    --flake "github:onnovalkering/configuration#${HOST_NAME}" \
    --disk main $DISK_NAME \
    --write-efi-boot-entries
```