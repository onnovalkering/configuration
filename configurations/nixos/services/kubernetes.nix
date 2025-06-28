_: {
  services.k3s.enable = true;
  services.k3s = {
    role = "server";
  };

  # Required to reach the Kubernetes API server.
  networking.firewall.allowedTCPPorts = [
    6443
    10250
  ];
}
