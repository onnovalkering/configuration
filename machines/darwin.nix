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
    
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    taps = [
      "homebrew/core"
      "homebrew/cask"
      "homebrew/cask-fonts"
    ];

    brews = [
      "nvm"
      "pyenv"
    ];

    casks = [
      "1password"
      "1password-cli"
      "font-fira-code-nerd-font"
      "kitty"
      "obsidian"
      "rectangle"
    ];

    masApps = {
        "1Password for Safari" = 1569813296;
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
