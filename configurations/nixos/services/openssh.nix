_: {
  services = {
    openssh.enable = true;
    openssh = {
      allowSFTP = true;
      openFirewall = true;

      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };

      extraConfig = ''
        AllowAgentForwarding yes
        AllowStreamLocalForwarding no
        AllowTcpForwarding yes
        AuthenticationMethods publickey
        ClientAliveCountMax 5
        ClientAliveInterval 30
        Compression no
        LoginGraceTime 20s
        MaxAuthTries 2
        MaxSessions 1
        TrustedUserCAKeys /etc/ssh/ca_key.pub
      '';
    };

    fail2ban.enable = true;
  };

  environment.etc = {
    "ssh/ca_key.pub".text = builtins.readFile ../files/ssh_ca_key.pub;
  };
}
