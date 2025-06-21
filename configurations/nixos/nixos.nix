{ config, pkgs, ... }@args:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.05";

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

  # Disable sleep/suspend/hibernate.
  systemd.targets = {
    hibernate.enable = false;
    hybrid-sleep.enable = false;
    sleep.enable = false;
    suspend.enable = false;
  };

  # Packages to be installed in system profile.
  environment = with pkgs; {
    systemPackages = [
      git
      vim
    ];
  };
}
