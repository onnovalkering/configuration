{ config, pkgs, ... }:
{
  system.stateVersion = "24.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure time and i18n.
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure networking.
  networking.hostName = "homeserver";
  networking.firewall.enable = true;
  networking.interfaces.eth0.useDHCP = true;
  networking.nftables.enable = true;

  # Configure security.  
  security.sudo.execWheelOnly = true;
  security.sudo.wheelNeedsPassword = false;

  # Configure container runtime.
  virtualisation.podman.enable = true;
  virtualisation.podman = {
    autoPrune.enable = true;
    dockerCompat = true;
    defaultNetwork.settings = {
      dns_enabled = true;
    };
  };

  # Configure user accounts.
  programs.fish.enable = true; 
  users.users.onno = {
    isNormalUser = true;
    home = "/home/onno";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIkAtn+2JTthPhy/lD6pa5/3A6tkGD+OBmdqeni7vz0s"
    ];
  };

  # Packages to be installed in system profile.
  environment.systemPackages = with pkgs; [
   git
   podman-compose
   podman-tui
   vim
  ];
}
