{ pkgs, ... }:
{
  imports = [
    ./programs/bat.nix
    ./programs/bottom.nix
    ./programs/direnv.nix
    ./programs/fish.nix
    ./programs/git.nix
    ./programs/nvim.nix
    ./programs/ssh.nix
    ./programs/tmux.nix
    ./programs/yazi.nix
  ];

  home = {
    username = "onno";
    keyboard.layout = "us";
    stateVersion = "25.11";

    sessionVariables = {
      EDITOR = "nvim";
      TERM = "xterm";
    };

    file.".hushlogin".text = "";

    packages = with pkgs; [
      ansible
      aria2
      colordiff
      coreutils
      csvkit
      curl
      dig
      findutils
      gawk
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
