{ config, pkgs, ... }:

let
  imports = [
    ./modules/fish.nix
    ./modules/git.nix
    ./modules/home-manager.nix
    ./modules/tmux.nix
  ];

in {
  inherit imports;

  # Let Home Manager manage itself.
  programs.home-manager.enable = true;

  home.username = "onno";
  home.keyboard.layout = "us";
  home.stateVersion = "24.11";

  home.sessionVariables = {
    TERM = "xterm";
  };

  home.packages = with pkgs; with nodePackages; [
    colordiff
    coreutils
    csvkit
    findutils
    gawk
    gnumake
    gnused
    gnutar
    htop
    httpie
    jq
    moreutils
    mitmproxy
    netcat
    nmap
  ];
}
