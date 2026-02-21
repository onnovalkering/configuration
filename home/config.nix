{
  catppuccin-hm,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
let
  inherit (pkgs.stdenv) isDarwin isLinux;
in
{
  home-manager = {
    extraSpecialArgs = {
      inherit pkgs-unstable;
    };

    useGlobalPkgs = true;
    useUserPackages = true;
    users.onno = {
      imports = [ ./home.nix ];

      xdg.configFile = lib.mkIf isDarwin {
        "kanata/internal.kbd".source = ./files/kanata/internal.kbd;
        "kanata/mx-keys.kbd".source = ./files/kanata/mx-keys.kbd;
        "kanata/shared.kbd".source = ./files/kanata/shared.kbd;
      };
    };

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

    # Linux-specific configuration.
    (lib.mkIf isLinux {
      extraGroups = [
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
