{ config, pkgs, ... }:

let
  imports = [
    ../modules/fish.nix
    ../modules/git.nix
    ../modules/home-manager.nix
    ../modules/kitty.nix
    ../modules/neovim.nix
    ../modules/tmux.nix
  ];

in {
  inherit imports;

  home.username = "onno";
  home.homeDirectory = "/Users/onno";
  home.keyboard.layout = "us";
  home.stateVersion = "21.11";

  home.packages = with pkgs; [
    aria2
    bat
    calc
    cmake
    colordiff
    coreutils
    findutils
    gawk
    gcc
    gnumake
    gnupg
    gnused
    gnutar
    grpcurl
    htop
    httpie
    hugo
    iperf3
    jq
    kubectl
    lazygit
    mitmproxy
    nmap
    nodejs 
    p7zip 
    parallel
    pipenv
    python3
    python3Packages.pip
    ripgrep
    rclone
    rsync 
    speedtest-cli
    sqlite
  ];
}
