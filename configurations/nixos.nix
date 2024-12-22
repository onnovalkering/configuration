{ config, pkgs, ... }:
{
  system.stateVersion = "24.11";
  nix.allowedUsers = [ "@wheel" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Configure time and i18n.
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure networking.
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

  systemd.services.tailscale-autoconnect = {
    description = "Automatic connection to Tailscale";

    # Make sure tailscale is running before trying to connect to tailscale.
    after = [ "network-pre.target" "tailscale.service" ];
    wants = [ "network-pre.target" "tailscale.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig.Type = "oneshot";
    script = with pkgs; ''
      # wait for tailscaled to settle
      sleep 2

      # check if we are already authenticated to tailscale
      status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
      if [ $status = "Running" ]; then # if so, then do nothing
        exit 0
      fi

      ${tailscale}/bin/tailscale up
    '';
  };
}