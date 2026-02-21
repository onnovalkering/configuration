{ pkgs, hostName, ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.11";

  # WSL-specific settings.
  wsl = {
    enable = true;
    defaultUser = "onno";
  };

  # Configure time and i18n.
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure networking.
  networking = {
    inherit hostName;
  };

  # Configure security.
  security = {
    sudo = {
      execWheelOnly = true;
      wheelNeedsPassword = false;
    };
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
      opencode
      vim
    ];
  };
}
