{ config, pkgs, ... }:
{
  services.openssh.enable = true;
  services.openssh = {
    allowSFTP = true;
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
    "ssh/ca_key.pub".text = builtins.readFile ../files/ssh_ca_key.pub;
  };
}
