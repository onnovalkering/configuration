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
  home.stateVersion = "22.11";

  home.sessionVariables = {
    TERM = "xterm";
  };

  home.packages = with pkgs; [
    ansible
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
    moreutils
    nmap
    p7zip 
    packer
    pipenv
    ripgrep
    rsync 
    shellcheck
    speedtest-cli
    sqlite
    terraform
    vagrant
  ];
}
