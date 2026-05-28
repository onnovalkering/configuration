{ pkgs, ... }:
{
  imports = [ ./programs ];

  home = {
    username = "onno";
    keyboard.layout = "us";
    stateVersion = "26.05";

    sessionVariables = {
      EDITOR = "nvim";
      TERM = "xterm";
    };

    file.".hushlogin".text = "";

    packages = with pkgs; [
      age
      ansible
      aria2
      colordiff
      coreutils
      csvkit
      curl
      dig
      findutils
      gawk
      gemini-cli
      gh
      gnumake
      gnupg
      gnused
      gnutar
      htop
      httpie
      imagemagick
      jq
      kubectl
      mitmproxy
      moreutils
      netcat
      nmap
      ripgrep
      tree
      wget
      zoxide
    ];
  };
}
