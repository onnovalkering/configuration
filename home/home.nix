{ config, pkgs, ... }:

let
  imports = [
    ./modules/fish.nix
    ./modules/git.nix
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
