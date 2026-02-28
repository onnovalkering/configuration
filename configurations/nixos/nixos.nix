{
  pkgs,
  hostName,
  lib,
  enableFirewall,
  enableAutoUpgrade,
  ...
}:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.11";

  # Configure kernel parameters.
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  # Configure time and i18n.
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  # Virtualisation
  virtualisation.podman.enable = true;
  virtualisation.oci-containers.backend = "podman";

  # Configure networking.
  networking = {
    inherit hostName;
    firewall.enable = enableFirewall;
    nftables.enable = enableFirewall;
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
  system.autoUpgrade = lib.mkIf enableAutoUpgrade {
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
