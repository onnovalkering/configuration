{ pkgs, ... }@args:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 5;

  # Configure networking.
  networking = {
    inherit (args) hostName;
  };

  # Configure security.
  security.pam.services.sudo_local.touchIdAuth = true;

  # Configure system.
  system = {
    primaryUser = "onno";

    defaults = {
      dock = {
        autohide = true;
        mru-spaces = false;
        orientation = "left";
        show-recents = false;
      };

      finder = {
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "clmv";
      };

      loginwindow = {
        GuestEnabled = false;
      };

      NSGlobalDomain = {
        AppleFontSmoothing = 1;
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 20;
        KeyRepeat = 1;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };

  # Applications to install.
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    brews = [
      "incus"
    ];

    casks = [
      "ghostty"
      "raycast"
      "rectangle"
      "tailscale-app"
      "zed"
    ];
  };

  # Packages to be installed in system profile.
  environment = with pkgs; {
    systemPackages = [
      bun
      pyenv
      rustup
    ];
  };
}
