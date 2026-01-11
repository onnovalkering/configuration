{
  catppuccin-hm,
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin isLinux;
in
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.onno = import ./home.nix;

    sharedModules = [ catppuccin-hm ];
  };

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
    (lib.mkIf isLinux {
      extraGroups = [
        "incus-admin"
        "wheel"
      ];
      home = "/home/onno";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        (builtins.readFile ./files/ssh_id_key.pub)
      ];
    })
  ];
}
