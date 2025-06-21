# Configuration
This repository contains my configurations, most of it relies on Nix.

## Darwin
To update the system, run the following command:
```
$ sudo darwin-rebuild switch --flake github:onnovalkering/configuration
```

## NixOS
Boot into the live environment and run the following command:
```
$ curl -sLO https://raw.githubusercontent.com/onnovalkering/configuration/main/install.sh
$ bash install.sh
```

To update the system, run the following command:
```
$ sudo nixos-rebuild switch --flake github:onnovalkering/configuration
```
