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

  home.packages = with pkgs; with nodePackages; [
    ansible
    ansible-lint
    azure-cli
    aria2
    bat
    colordiff
    coreutils
    csvkit
    findutils
    fx
    fnm
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
    mitmproxy
    netcat
    nmap
    p7zip 
    pnpm
    ripgrep
    rsync 
    shellcheck
    speedtest-cli
    sqlite
    virtualenv
  ];
}
