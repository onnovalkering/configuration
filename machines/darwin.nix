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
      home-manager
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
    users.onno = (import ../homes/darwin.nix);
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
      "alfred"
      "cyberduck"
      "eset-cyber-security-pro"
      "font-fira-code-nerd-font"
      "kitty"
      "rectangle"
      "signal"
      "syncthing"
      "visual-studio-code"
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
        _HIHideMenuBar = true;
      };
    }; 

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
  };
}
