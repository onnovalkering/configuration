{ inputs, self }:
let
  inherit (inputs)
    nixpkgs
    nixpkgs-unstable
    catppuccin
    home-manager
    nix-darwin
    disko
    ;

  mkSpecialArgs =
    system: extra:
    {
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      catppuccin-hm = catppuccin.homeModules.catppuccin;
    }
    // extra;
in
{
  mkNixos =
    {
      hostName,
      modules,
      system ? "x86_64-linux",
      specialArgs ? { },
    }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = mkSpecialArgs system ({ inherit hostName; } // specialArgs);
      modules = [
        disko.nixosModules.disko
        home-manager.nixosModules.home-manager
        "${self}/configurations/nixos/nixos.nix"
        "${self}/home/config.nix"
      ]
      ++ modules;
    };

  mkDarwin =
    {
      hostName,
      modules,
      system ? "aarch64-darwin",
      specialArgs ? { },
    }:
    nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = mkSpecialArgs system ({ inherit hostName; } // specialArgs);
      modules = [
        home-manager.darwinModules.home-manager
        "${self}/configurations/darwin/darwin.nix"
        "${self}/home/config.nix"
      ]
      ++ modules;
    };
}
