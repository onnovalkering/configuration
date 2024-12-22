{
  description = "A flake for my Nix configuration on macOS and NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";    
  };

  outputs = { self, nixpkgs, disko }: {
    nixosConfigurations = {
      homeserver = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./hardware/intel-nuc.nix
	        ./configurations/nixos/nixos.nix
          ./configurations/nixos/roles/openssh.nix
          ./configurations/nixos/roles/tailscale.nix
        ];
        specialArgs = {
          hostName = "homeserver";
        };
      };
    };
  };
}