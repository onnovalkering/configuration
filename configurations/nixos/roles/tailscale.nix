{ config, pkgs, ... }:
{ 
  services.tailscale.enable = true;
  services.tailscale = {
    openFirewall = true;
  };

  # systemd.services.tailscale-autoconnect = {
  #   description = "Automatic connection to Tailscale";

  #   # Make sure tailscale is running before trying to connect to tailscale.
  #   after = [ "network-pre.target" "tailscale.service" ];
  #   wants = [ "network-pre.target" "tailscale.service" ];
  #   wantedBy = [ "multi-user.target" ];

  #   serviceConfig.Type = "oneshot";
  #   script = with pkgs; ''
  #     # Wait for tailscaled to settle
  #     sleep 2

  #     # Check if we are already authenticated to tailscale.
  #     status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
  #     if [ $status = "Running" ]; then
  #       exit 0
  #     fi

  #     ${tailscale}/bin/tailscale up
  #   '';
  # };
}