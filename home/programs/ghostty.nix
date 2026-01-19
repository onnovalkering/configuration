_: {
  programs.ghostty = {
    enable = true;
    package = null;

    systemd = {
      enable = false;
    };

    settings = {
      font-size = 14;
      mouse-hide-while-typing = true;
      title = " ";
      window-decoration = false;
    };
  };

  catppuccin.ghostty = {
    enable = true;
    flavor = "mocha";
  };
}
