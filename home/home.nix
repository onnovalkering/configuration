{ config, pkgs, ... }@args:

let
  imports = [
    ./modules/fish.nix
    ./modules/git.nix
    ./modules/ssh.nix
    ./modules/tmux.nix
  ];

in {
  inherit imports;

  home.username = "onno";
  home.keyboard.layout = "us";
  home.stateVersion = "25.05";

  home.sessionVariables = {
    TERM = "xterm";
  };

  home.packages = with pkgs; [
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
    mitmproxy
    moreutils
    netcat
    nmap
    ripgrep
    tree
    wget
  ];
}
