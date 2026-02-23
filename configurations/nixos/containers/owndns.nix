_: {
  virtualisation.oci-containers = {
    containers.owndns = {
      image = "ghcr.io/onnovalkering/owndns:latest";
      ports = [
        "53:53/tcp"
        "53:53/udp"
      ];
      extraOptions = [
        "--cap-add=NET_BIND_SERVICE"
      ];
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 53 ];
    allowedUDPPorts = [ 53 ];
  };
}
