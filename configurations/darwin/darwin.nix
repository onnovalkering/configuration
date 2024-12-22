{ config, pkgs, ... }:
{
  imports = [ <home-manager/nix-darwin> ];

  # Enable daemon for automatic updates.
  services.nix-daemon.enable = true;

  environment = with pkgs; {
    shells = [
      fish
    ];
    systemPackages = [
      nodejs_20
      pipenv
      python311
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

  home-manager = {
    useUserPackages = true;
    users.onno = (import ../home/home.nix);
  };

  homebrew = {
    enable = true;
    
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    casks = [
      "font-monaspace"
      "raycast"
      "tailscale"
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
