{ pkgs, ... }:
{
  programs = {
    ssh = {
      enable = true;

      addKeysToAgent = "yes";
      extraConfig = ''
        useKeychain = yes
      '';
    };
  };
}
