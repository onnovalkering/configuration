# Configuration
This repository contains my configurations, most of it relies on Nix.

## NixOS
Boot into the live environment and run the following command:

```
$ export HOST_NAME="homeserver"
$ export DISK_NAME="/dev/nvme0n1"
$ sudo nix run "github:nix-community/disko#disko-install" \
    --experimental-features "nix-command flakes" -- \
    --flake "github:onnovalkering/configuration#${HOST_NAME}" \
    --disk main $DISK_NAME \
    --write-efi-boot-entries
```

To update the system, run the following command:

```
$ sudo nixos-rebuild switch --flake github:onnovalkering/configuration
```