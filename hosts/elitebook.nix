{ inputs, self, ... }:
let
  system = "x86_64-linux";
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
  catppuccin-hm = inputs.catppuccin.homeModules.catppuccin;

  inherit (inputs.home-manager.nixosModules) home-manager;
  inherit (inputs.nixos-wsl.nixosModules) default;
  inherit (inputs.nixpkgs.lib) nixosSystem;
in
{
  flake.nixosConfigurations = {
    elitebook = nixosSystem {
      inherit system;
      specialArgs = {
        hostName = "elitebook";
        enableFirewall = false;
        enableAutoUpgrade = false;
        inherit catppuccin-hm pkgs-unstable;
      };
      modules = [
        default
        "${self}/hardware/wsl.nix"
        "${self}/configurations/nixos/nixos.nix"
        home-manager
        "${self}/home/config.nix"
      ];
    };
  };
}
