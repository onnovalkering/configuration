{ config, pkgs, ... }:
{
  system.stateVersion = "24.05";
  nix.allowedUsers = [ "@wheel" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure runtime kernel parameters.
  boot.kernel = {
    sysctl = {
      "net.ipv4.ip_forward" = "1";
      "net.ipv6.conf.all.forwarding" = "1";
    };
  };

  # Configure time and i18n.
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure networking.
  networking.hostName = "nixos";
  networking.firewall.enable = true;
  networking.interfaces.eth0.useDHCP = true;
  networking.nftables.enable = true;

  # Configure security.  
  security.sudo.execWheelOnly = true;
  security.sudo.wheelNeedsPassword = false;
  
  programs.fish.enable = true; 
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
  # environment.defaultPackages = lib.mkForce [];
  environment.systemPackages = with pkgs; [
   vim
   git
  ];

  # Enable the OpenSSH service.
  services.openssh.enable = true;
  services.openssh = {
    allowSFTP = false;
    openFirewall = true;

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };

    extraConfig = ''
      AllowAgentForwarding no
      AllowStreamLocalForwarding no
      AllowTcpForwarding yes
      AuthenticationMethods publickey
      TrustedUserCAKeys /etc/ssh/ca_key.pub
      X11Forwarding no
    '';
  };

  environment.etc = {
    "ssh/ca_key.pub".text = builtins.readFile ./files/ssh_ca_key.pub;
  };

  # Enable the Tailscale service.
  services.tailscale.enable = true;
  services.tailscale = {
    openFirewall = true;
  };

  systemd.services.tailscaled-autoconnect = {
    preStart = ''
      ${pkgs.ethtool}/bin/ethtool -K eth0 rx-udp-gro-forwarding on rx-gro-list off
    '';
  };  
}