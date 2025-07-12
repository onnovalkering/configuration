{ pkgs, ... }@args:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.05";

  # Configure bootloader and kernel parameters.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };
  };

  # Configure time and i18n.
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure networking.
  networking = {
    inherit (args) hostName;
    firewall.enable = true;
    nftables.enable = true;

    interfaces.eth0.useDHCP = true;
  };

  # Configure security.
  security = {
    sudo = {
      execWheelOnly = true;
      wheelNeedsPassword = false;
    };
  };

  # Disable sleep/suspend/hibernate.
  systemd.targets = {
    hibernate.enable = false;
    hybrid-sleep.enable = false;
    sleep.enable = false;
    suspend.enable = false;
  };

  # Enable automatic upgrades of the system.
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    flake = "github:onnovalkering/configuration";
    dates = "Sun 22:00";
    flags = [ "--refresh" ];
  };

  # Enable automatic garbage collection.
  nix.gc = {
    automatic = true;
    dates = "Sat 22:00";
    options = "--delete-older-than 30d";
  };

  # Packages to be installed in system profile.
  environment = with pkgs; {
    systemPackages = [
      git
      vim
    ];
  };
}
