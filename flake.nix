{
  description = "A flake for my Nix configuration on macOS and NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

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

  outputs = inputs@{
    self,
    disko,
    home-manager,
    nix-darwin,
    nixpkgs,
    nixpkgs-unstable,
    ...
  }: {
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

    nixosConfigurations = let
      system = "x86_64-linux";
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system}.pkgs;
    in {
      server-vesta = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          hostName = "server-vesta";
          inherit pkgs-unstable;
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
        inherit system;
        specialArgs = {
          hostName = "server-vulcan";
          inherit pkgs-unstable;
        };
        modules = [
          disko.nixosModules.disko
          ./hardware/intel-aipc-devkit.nix
          ./configurations/nixos/nixos.nix
          ./configurations/nixos/services/kubernetes.nix
          ./configurations/nixos/services/openssh.nix
          ./configurations/nixos/services/tailscale.nix
          home-manager.nixosModules.home-manager
          ./home/config.nix
        ];
      };
    };
  };
}
