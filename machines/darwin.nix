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
      nodejs-16_x
      python3
      python3Packages.pip
      rustup
    ];
  };

  programs.fish.enable = true;
  users = {
    users = {
      onno = {
        home = "/Users/onno";
        shell = pkgs.fish;
      };
    };
  };

  home-manager = {
    useUserPackages = true;
    users.onno = (import ../home/home.nix);
  };

  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";

    taps = [
      "homebrew/core"
      "homebrew/cask"
      "homebrew/cask-fonts"
    ];

    casks = [
      "1password"
      "1password-cli"
      "font-fira-code-nerd-font"
      "kitty"
      "obsidian" 
      "raycast"
      "rectangle"
      "resilio-sync"
      "signal"
      "tailscale"
    ];

    masApps = {
        "1Password for Safari" = 1569813296;
        "GoodNotes" = 1444383602;
        "Xcode" = 497799835;
    };
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
    }; 

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };
}
