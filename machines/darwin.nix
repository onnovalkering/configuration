{ config, pkgs, ... }:

{
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

  users = {
    users = {
      onno = {
        home = "/Users/onno";
        shell = pkgs.fish;
      };
    };
  };

  services.nix-daemon.enable = true;
  programs.fish.enable = true;

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
      "alfred"
      "cyberduck"
      "eset-cyber-security-pro"
      "font-fira-code-nerd-font"
      "insomnia"
      "microsoft-remote-desktop"
      "rectangle"
      "signal"
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
        InitialKeyRepeat = 10;
        KeyRepeat = 1;
        _HIHideMenuBar = true;
      };
    }; 
  };

  keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
}
