# Configuration
This repository contains my configurations, most of it relies on Nix.

## NixOS
Boot into the live environment and run the following command:

```
$ export HOST_NAME="server-<name>"
$ sudo nix run "github:nix-community/disko#disko-install" \
    --experimental-features "nix-command flakes" -- \
    --flake "github:onnovalkering/configuration#${HOST_NAME}" \
    --disk main /dev/nvme0n1 \
    --write-efi-boot-entries
```

To update the system, run the following command:

```
$ sudo nixos-rebuild switch --flake github:onnovalkering/configuration
```
