{ pkgs, ... }:
let
  inherit (pkgs.stdenv) isDarwin;
in
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    # On macOS use the system provided SSH binary.
    package = if isDarwin then null else pkgs.openssh;

    matchBlocks = {
      "*" = { };

      "server-vesta" = {
        forwardAgent = true;
      };

      "server-vulcan" = {
        forwardAgent = true;
      };
    };

    # On macOS use keychain for SSH passphrases.
    extraConfig = ''
      IgnoreUnknown UseKeychain
      UseKeychain yes
    '';
  };
}
