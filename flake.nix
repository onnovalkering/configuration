{
  description = "A flake for my Nix configuration on macOS and NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, nixpkgs }: {
    darwinConfigurations = {
      darwin = {
        system = "aarch64-darwin";
        modules = [ ./configurations/darwin.nix ];
      };
    };

    nixosConfigurations = {
      nixos = {
        system = "x86_64-linux";
        modules = [ ./configurations/nixos.nix ];
      };
    };
  };
}