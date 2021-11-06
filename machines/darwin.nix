{ config, pkgs, ... }:

let
  imports = [
    ../modules/fish.nix
    ../modules/git.nix
    ../modules/home-manager.nix
    ../modules/neovim.nix
    ../modules/tmux.nix
  ];

in {
  inherit imports;

  home.username = "onno";
  home.homeDirectory = "/Users/onno";
  home.keyboard.layout = "us";
  home.stateVersion = "21.05";

  home.packages = with pkgs; [
    aria2
    calc
    cargo
    cmake
    colordiff
    coreutils
    findutils
    gawk
    gnupg
    gnumake
    gnused
    gnutar
    grpcurl
    htop
    httpie
    hugo
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
#    ripgrep
    rclone
    rsync 
    rustc
    speedtest-cli
    sqlite
  ];
}
