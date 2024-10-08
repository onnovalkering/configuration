{ config, pkgs, ... }:
{
  system.stateVersion = "24.05";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure time and i18n.
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure networking.
  networking.hostName = "nixos";
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
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIkAtn+2JTthPhy/lD6pa5/3A6tkGD+OBmdqeni7vz0s"
    ];
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

    extraConfig = ''
      TrustedUserCAKeys /etc/ssh/ca_key.pub
    '';
  };

  environment.etc."ssh/ca_key.pub".text = builtins.readFile ./files/ssh_ca_key.pub;
}