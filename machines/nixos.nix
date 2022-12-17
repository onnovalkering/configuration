{
  imports = [ 
    /etc/nixos/hardware-configuration.nix
  ];

  system.stateVersion = "22.11";

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

  # Configure 'onno' user.
  users.users.onno = {
    isNormalUser = true;
    home = "/home/onno";
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
       "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPR9rgGC7DB79Ym3mo/n7tKrZn9I/JBweFNlNu5jf7Mu"
    ];
  };

  # Packages to be installed in system profile.
  environment.systemPackages = with pkgs; [
    gcc
    gnupg
    git
    home-manager
    nodejs
    openssl
    podman
    podman-compose
    python3
    python3Packages.pip
    rustup
    sqlite
    vim
  ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };
}
