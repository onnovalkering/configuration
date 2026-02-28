{ inputs, self, ... }:
let
  system = "aarch64-darwin";
  pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
  catppuccin-hm = inputs.catppuccin.homeModules.catppuccin;

  inherit (inputs.nix-darwin.lib) darwinSystem;
  inherit (inputs.home-manager.darwinModules) home-manager;
in
{
  flake.darwinConfigurations = {
    macbook-pro = darwinSystem {
      inherit system;
      specialArgs = {
        hostName = "macbook-pro";
        inherit catppuccin-hm pkgs-unstable;
      };
      modules = [
        "${self}/configurations/darwin/darwin.nix"
        "${self}/configurations/darwin/launch-agents"
        "${self}/configurations/darwin/launch-daemons"
        "${self}/configurations/darwin/services"
        home-manager
        "${self}/home/config.nix"
      ];
    };
  };
}
