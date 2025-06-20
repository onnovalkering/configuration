{ config, pkgs, ... }@args:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
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

  # Configure user accounts.
  users.users.onno = {
    isNormalUser = true;
    home = "/home/onno";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAGqt8WH23sc4UXBQoalmG5qnazUuOUd/wn039CZNY2e5GUbwOMHuOasYLisGS9lfE2NaaUqnMn0u612vPCqcU5KBAF4xAV2aT0fnRP/ZdEir2dvJ11CCTWlvj2fYITtffywyKgdVCa90gmBm6TA7c4kp0NBoDeOJ8Rgbowt+pTWLz+7qw=="
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
