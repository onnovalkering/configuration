{ pkgs, pkgs-unstable, ... }:
{
  services = {
    tailscale = {
      enable = true;
      package = pkgs-unstable.tailscale;

      extraSetFlags = [ "--advertise-exit-node" ];
      openFirewall = true;
      useRoutingFeatures = "server";
    };

    networkd-dispatcher = {
      enable = true;

      rules."50-tailscale-udp-optimization" = {
        onState = [ "routable" ];
        script = ''
          #!${pkgs.runtimeShell}
          ${pkgs.ethtool}/bin/ethtool -K eth0 rx-udp-gro-forwarding on rx-gro-list off
        '';
      };
    };
  };
}
