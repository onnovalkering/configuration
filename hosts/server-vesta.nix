{ inputs, self, ... }:
let
  system = "x86_64-linux";
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
  catppuccin-hm = inputs.catppuccin.homeModules.catppuccin;

  inherit (inputs.disko.nixosModules) disko;
  inherit (inputs.home-manager.nixosModules) home-manager;
  inherit (inputs.nixpkgs.lib) nixosSystem;
in
{
  flake.nixosConfigurations = {
    server-vesta = nixosSystem {
      inherit system;
      specialArgs = {
        hostName = "server-vesta";
        enableFirewall = true;
        enableAutoUpgrade = true;
        inherit catppuccin-hm pkgs-unstable;
      };
      modules = [
        disko
        "${self}/hardware/intel-nuc-11-ess.nix"
        "${self}/configurations/nixos/nixos.nix"
        "${self}/configurations/nixos/containers/owndns.nix"
        "${self}/configurations/nixos/services/kubernetes.nix"
        "${self}/configurations/nixos/services/openssh.nix"
        "${self}/configurations/nixos/services/tailscale.nix"
        home-manager
        "${self}/home/config.nix"
      ];
    };
  };
}
