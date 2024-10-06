{ config, pkgs, hostName ? "nixos" ... }:
{
  system.stateVersion = "24.05";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure time and i18n.
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure networking.
  networking.hostName = hostName;
  networking.interfaces.eth0.useDHCP = true;

  # Configure security.  
  security.sudo.wheelNeedsPassword = false;
  
  programs.fish.enable = true; 
 
  # Configure 'onno' user.
  users.users.onno = {
    isNormalUser = true;
    home = "/home/onno";
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  # Packages to be installed in system profile.
  environment.systemPackages = with pkgs; [
   vim
   git
  ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
}