{ config, pkgs, ... }:
let
  imports = [
    ./programs/fish.nix
    ./programs/git.nix
    ./programs/ssh.nix
    ./programs/tmux.nix
  ];
in
{
  inherit imports;

  home.username = "onno";
  home.keyboard.layout = "us";
  home.stateVersion = "25.05";

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
    kubectl
    mitmproxy
    moreutils
    netcat
    nmap
    ripgrep
    tree
    wget
  ];
}
