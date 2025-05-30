{ config, pkgs, ... }@args:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "24.11";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure time and i18n.
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure networking.
  networking.hostName = args.hostName;
  networking.firewall.enable = true;
  networking.interfaces.eth0.useDHCP = true;
  networking.nftables.enable = true;

  # Configure security.
  security.sudo.execWheelOnly = true;
  security.sudo.wheelNeedsPassword = false;

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
  environment = with pkgs; {
    systemPackages = [
      git
      vim
    ];
  };
}
