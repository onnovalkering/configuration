_: {
  virtualisation.oci-containers.containers = {
    ts-jellyfin = {
      image = "tailscale/tailscale:v1.94.2";
      hostname = "jellyfin";
      environment = {
        TS_HOSTNAME = "jellyfin";
        TS_STATE_DIR = "/var/lib/tailscale";
        TS_SERVE_CONFIG = "/config/jellyfin.json";
        TS_USERSPACE = "true";
      };
      environmentFiles = [
        "/etc/secrets/ts-jellyfin-authkey"
      ];
      volumes = [
        "ts-jellyfin-state:/var/lib/tailscale"
        "/etc/tailscale/jellyfin.json:/config/jellyfin.json:ro"
      ];
    };

    jellyfin = {
      image = "jellyfin/jellyfin:2026022305";
      dependsOn = [ "ts-jellyfin" ];
      environment = {
        JELLYFIN_PublishedServerUrl = "https://jellyfin.stargazer-ulmer.ts.net";
      };
      volumes = [
        "jellyfin-config:/config"
        "jellyfin-cache:/cache"
        "/srv/media:/media:ro"
      ];
      extraOptions = [
        "--network=container:ts-jellyfin"
      ];
    };
  };

  environment.etc."tailscale/jellyfin.json".text = builtins.toJSON {
    TCP."443".HTTPS = true;
    Web."\${TS_CERT_DOMAIN}:443".Handlers."/".Proxy = "http://127.0.0.1:8096";
  };

  systemd.tmpfiles.rules = [
    "d /srv/media 0755 root root -"
  ];
}
