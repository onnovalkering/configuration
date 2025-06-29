{ pkgs-unstable, ... }:
{
  virtualisation.incus.enable = true;
  virtualisation.incus = {
    ui.enable = true;

    # Use the latest version of Tailscale.
    package = pkgs-unstable.incus;
  };

  networking.firewall = {
    trustedInterfaces = [
      "incusbr0"
    ];
  };
}
