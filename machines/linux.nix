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
  home.homeDirectory = "/home/onno";
  home.keyboard.layout = "us";
  home.stateVersion = "21.05";

  home.sessionVariables = {
    TERM = "xterm";
  };

  home.sessionVariablesExtra = ''
    export GPG_TTY=$(tty)
  '';

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
    jq
    kubectl
    lazygit
    mitmproxy
    nmap
    nodejs 
    p7zip 
    parallel
    pipenv
    podman
    podman-compose
    python3
    python3Packages.pip
    rclone
    ripgrep
    rsync 
    rustup
    speedtest-cli
    sqlite
  ];
}
