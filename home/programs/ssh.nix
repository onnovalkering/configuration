{ pkgs, lib, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  programs.ssh = lib.mkMerge [
    {
      enable = true;
    }

    # Darwin-specific configuration.
    (lib.mkIf isDarwin {
      addKeysToAgent = "yes";
      extraConfig = ''
        useKeychain = yes
      '';
    })
  ];
}
