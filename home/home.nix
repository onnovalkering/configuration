{ pkgs, ... }:
{
  imports = [
    ./programs/direnv.nix
    ./programs/fish.nix
    ./programs/git.nix
    ./programs/ssh.nix
    ./programs/tmux.nix
  ];

  home.username = "onno";
  home.keyboard.layout = "us";
  home.stateVersion = "25.05";

  home.sessionVariables = {
    TERM = "xterm";
  };

  home.packages = with pkgs; [
    aria2
    bat
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
}
