# Configuration

This repository contains my Nix configurations for reproducible and declarative systems.

## Darwin

To apply or update the system, run the following command:

```sh
sudo darwin-rebuild switch --flake github:onnovalkering/configuration
```

## NixOS

Boot into the NixOS installer and run the installation script:

```sh
curl -sLO https://raw.githubusercontent.com/onnovalkering/configuration/main/install.sh
bash install.sh
```

To apply or update the system, run the following command:

```sh
sudo nixos-rebuild switch --flake github:onnovalkering/configuration
```
