{
  description = "A flake for my Nix configuration on macOS and NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, disko, home-manager, ... }: {
    nixosConfigurations = {
      homeserver = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          hostName = "homeserver";
        };
        modules = [
          disko.nixosModules.disko
          ./hardware/intel-nuc.nix
          ./configurations/nixos/nixos.nix
          ./configurations/nixos/services/docker.nix
          ./configurations/nixos/services/openssh.nix
          ./configurations/nixos/services/tailscale.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.onno = import ./home/home.nix;
          }
        ];
      };
    };
  };
}
