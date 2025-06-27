{ pkgs, lib, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
  isNixOS = pkgs.stdenv.isLinux;
in
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.onno = import ./home.nix;

  users.users.onno = lib.mkMerge [
    {
      shell = pkgs.fish;
      ignoreShellProgramCheck = true;
    }

    # Darwin-specific configuration.
    (lib.mkIf isDarwin {
      home = "/Users/onno";
    })

    # NixOS-specific configuration.
    (lib.mkIf isNixOS {
      extraGroups = [ "wheel" ];
      home = "/home/onno";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        (builtins.readFile ./files/ssh_id_key.pub)
      ];
    })
  ];
}
