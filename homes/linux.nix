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
  home.stateVersion = "21.11";

  home.sessionVariables = {
    TERM = "xterm";
  };

  home.sessionVariablesExtra = ''
    export GPG_TTY=$(tty)
  '';

  home.packages = with pkgs; [
    aria2
    bat
    bc
    cmake
    colordiff
    coreutils
    csvkit
    findutils
    fx
    gawk
    gnumake
    gnupg
    gnused
    gnutar
    gron
    htop
    httpie
    iperf3
    jq
    kubectl
    lazygit
    mitmproxy
    moreutils
    nmap
    p7zip 
    pipenv
    ripgrep
    rsync 
    speedtest-cli
    sqlite
  ];
}
