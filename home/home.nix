{ config, pkgs, ... }:

let
  imports = [
    ./modules/fish.nix
    ./modules/git.nix
    ./modules/home-manager.nix
    ./modules/kitty.nix
    ./modules/neovim.nix
    ./modules/tmux.nix
  ];

in {
  inherit imports;

  home.username = "onno";
  home.keyboard.layout = "us";
  home.stateVersion = "23.05";

  home.sessionVariables = {
    TERM = "xterm";
  };

  home.packages = with pkgs; [
    ansible
    aria2
    bat
    colordiff
    coreutils
    csvkit
    findutils
    fx
    gawk
    gnumake
    gnused
    gnutar
    gron
    htop
    httpie
    iperf3
    jq
    kubectl
    moreutils
    nmap
    p7zip 
    ripgrep
    rsync 
    shellcheck
    speedtest-cli
    sqlite
  ];
}
