{ pkgs-unstable, ... }:
{
  programs.opencode = {
    enable = true;
    package = pkgs-unstable.opencode;

    settings = {
      autoupdate = false;
      share = "disabled";

      permission = {
        bash = "ask";
        write = "allow";
      };
    };
  };

  catppuccin.opencode = {
    enable = true;
    flavor = "mocha";
  };
}
