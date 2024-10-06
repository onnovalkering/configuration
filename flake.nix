{
  description = "A flake for my Nix configuration on macOS and NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";    
  };

  outputs = { self, nixpkgs, disko }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./machines/intel-nuc.nix
	        ./configurations/nixos.nix
        ];
      };
    };
  };
}