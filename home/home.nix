{ config, pkgs, ... }@args:

let
  imports = [
    ./modules/fish.nix
    ./modules/git.nix
    ./modules/tmux.nix
  ];

in {
  inherit imports;

  home.username = "onno";
  home.keyboard.layout = "us";
  home.stateVersion = "24.11";

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
