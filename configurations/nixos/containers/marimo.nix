_: {
  virtualisation.oci-containers.containers = {
    ts-marimo = {
      image = "tailscale/tailscale:v1.94.2";
      hostname = "marimo";
      environment = {
        TS_HOSTNAME = "marimo";
        TS_STATE_DIR = "/var/lib/tailscale";
        TS_SERVE_CONFIG = "/config/marimo.json";
        TS_USERSPACE = "true";
      };
      environmentFiles = [
        "/etc/secrets/ts-marimo-authkey"
      ];
      volumes = [
        "ts-marimo-state:/var/lib/tailscale"
        "/etc/tailscale/marimo.json:/config/marimo.json:ro"
      ];
    };

    marimo = {
      image = "ghcr.io/marimo-team/marimo:0.20.2-sql";
      dependsOn = [ "ts-marimo" ];
      environment = {
        HOST = "127.0.0.1";
      };
      volumes = [
        "/srv/marimo:/app/data:ro"
      ];
      extraOptions = [
        "--network=container:ts-marimo"
      ];
    };
  };

  environment.etc."tailscale/marimo.json".text = builtins.toJSON {
    TCP."443".HTTPS = true;
    Web."\${TS_CERT_DOMAIN}:443".Handlers."/".Proxy = "http://127.0.0.1:8080";
  };

  systemd.tmpfiles.rules = [
    "d /srv/marimo 0755 root root -"
  ];
}
