{ config, pkgs, ... }:
{
  nix.enable = false;
  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.hostName = "macbook-pro";

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    casks = [
      "ghostty"
      "raycast"
      "rectangle"
      "tailscale"
      "zed"
    ];
  };

  security.pam.enableSudoTouchIdAuth = true;

  system = {
    stateVersion = 5;

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

      CustomUserPreferences = {
        NSUserKeyEquivalents = {
          Left = "~^←";
          Right = "~^→";
        };
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };
}
