{
  description = "A flake for my Nix configuration on macOS and NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, disko, nix-darwin, home-manager, ... }: {
    darwinConfigurations = {
      macbook-pro = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          hostName = "macbook-pro";
        };
        modules = [
          ./configurations/darwin/darwin.nix
          home-manager.darwinModules.home-manager
          ./home/config.nix
        ];
      };
    };

    nixosConfigurations = {
      server-vesta = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          hostName = "server-vesta";
        };
        modules = [
          disko.nixosModules.disko
          ./hardware/intel-nuc-11-ess.nix
          ./configurations/nixos/nixos.nix
          ./configurations/nixos/services/kubernetes.nix
          ./configurations/nixos/services/openssh.nix
          ./configurations/nixos/services/tailscale.nix
          home-manager.nixosModules.home-manager
          ./home/config.nix
        ];
      };

      server-vulcan = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          hostName = "server-vulcan";
        };
        modules = [
          disko.nixosModules.disko
          ./hardware/intel-aipc-devkit.nix
          ./configurations/nixos/nixos.nix
          # ./configurations/nixos/services/kubernetes.nix
          ./configurations/nixos/services/openssh.nix
          ./configurations/nixos/services/tailscale.nix
          home-manager.nixosModules.home-manager
          ./home/config.nix
        ];
      };
    };
  };
}
