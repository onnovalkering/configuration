{ config, pkgs-unstable, ... }:
{
  services.tailscale.enable = true;
  services.tailscale = {
    openFirewall = true;
    extraSetFlags = [ "--advertise-exit-node" ];

    # Use the latest version of Tailscale.
    package = pkgs-unstable.tailscale;
  };
}
