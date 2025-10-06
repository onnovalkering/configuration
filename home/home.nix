{ pkgs, ... }:
{
  imports = [
    ./programs/direnv.nix
    ./programs/fish.nix
    ./programs/git.nix
    ./programs/ssh.nix
    ./programs/tmux.nix
  ];

  home = {
    username = "onno";
    keyboard.layout = "us";
    stateVersion = "25.05";

    sessionVariables = {
      TERM = "xterm";
    };

    packages = with pkgs; [
      ansible
      aria2
      bat
      colordiff
      coreutils
      csvkit
      curl
      dig
      findutils
      flyctl
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
