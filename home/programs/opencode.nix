_: {
  programs.opencode = {
    enable = true;
    package = null;

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
