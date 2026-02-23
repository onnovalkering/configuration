{
  description = "A flake for my Nix configuration on macOS and NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      catppuccin,
      disko,
      home-manager,
      nix-darwin,
      nixos-wsl,
      nixpkgs,
      nixpkgs-unstable,
      pre-commit-hooks,
      ...
    }:
    let
      system-dev = "aarch64-darwin";
      pkgs-dev = nixpkgs-unstable.legacyPackages.${system-dev};
      catppuccin-hm = catppuccin.homeModules.catppuccin;
    in
    {
      darwinConfigurations =
        let
          system = "aarch64-darwin";
          pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
        in
        {
          macbook-pro = nix-darwin.lib.darwinSystem {
            inherit system;
            specialArgs = {
              hostName = "macbook-pro";
              inherit catppuccin-hm;
              inherit pkgs-unstable;
            };
            modules = [
              ./configurations/darwin/darwin.nix
              ./configurations/darwin/launch-agents
              ./configurations/darwin/launch-daemons
              ./configurations/darwin/services
              home-manager.darwinModules.home-manager
              ./home/config.nix
            ];
          };
        };

      nixosConfigurations =
        let
          system = "x86_64-linux";
          pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
        in
        {
          server-vesta = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              hostName = "server-vesta";
              inherit catppuccin-hm;
              inherit pkgs-unstable;
            };
            modules = [
              disko.nixosModules.disko
              ./hardware/intel-nuc-11-ess.nix
              ./configurations/nixos/nixos.nix
              ./configurations/nixos/containers/owndns.nix
              ./configurations/nixos/services/kubernetes.nix
              ./configurations/nixos/services/openssh.nix
              ./configurations/nixos/services/tailscale.nix
              home-manager.nixosModules.home-manager
              ./home/config.nix
            ];
          };

          wsl-nixos = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              hostName = "wsl-nixos";
              inherit catppuccin-hm;
              inherit pkgs-unstable;
            };
            modules = [
              nixos-wsl.nixosModules.default
              ./configurations/wsl/wsl.nix
              home-manager.nixosModules.home-manager
              ./home/config.nix
            ];
          };
        };

      checks.${system-dev}.pre-commit-check = pre-commit-hooks.lib.${system-dev}.run {
        src = ./.;
        hooks = {
          deadnix.enable = true;
          nixfmt-rfc-style.enable = true;
          statix.enable = true;
        };
      };

      devShells.${system-dev}.default = pkgs-dev.mkShell {
        inherit (self.checks.${system-dev}.pre-commit-check) shellHook;

        buildInputs = with pkgs-dev; [
          deadnix
          nil
          nixfmt-rfc-style
          statix
        ];
      };
    };
}
