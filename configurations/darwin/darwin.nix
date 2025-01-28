{ config, pkgs, ... }:
{
  # Enable daemon for automatic updates.
  services.nix-daemon.enable = true;

  environment = with pkgs; {
    # shells = [
    #   fish
    # ];
    systemPackages = [
      nodenv
      pyenv
      rustup
    ];
  };

  programs.fish.enable = true;
  users.users.onno = {
    isNormalUser = true;
    home = "/Users/onno";
    extraGroups = [ "admin" ];
    shell = pkgs.fish;
  }

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
      "tailscale"
      "zed"
    ];
  };

  system = {
    stateVersion = 4;

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
