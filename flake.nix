{
  description = "A flake for my Nix configuration on macOS and NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    catppuccin = {
      url = "github:catppuccin/nix/release-25.11";
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
          pkgs-unstable = nixpkgs-unstable.legacyPackages.${system}.pkgs;
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
          pkgs-unstable = nixpkgs-unstable.legacyPackages.${system}.pkgs;
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
              inherit catppuccin-hm;
              inherit pkgs-unstable;
            };
            modules = [
              disko.nixosModules.disko
              ./hardware/intel-aipc-devkit.nix
              ./configurations/nixos/nixos.nix
              ./configurations/nixos/services/openssh.nix
              ./configurations/nixos/services/incus.nix
              ./configurations/nixos/services/tailscale.nix
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
