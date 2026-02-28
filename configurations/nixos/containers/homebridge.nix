_: {
  virtualisation.oci-containers.containers = {
    ts-homebridge = {
      image = "tailscale/tailscale:v1.94.2";
      hostname = "homebridge";
      environment = {
        TS_HOSTNAME = "homebridge";
        TS_STATE_DIR = "/var/lib/tailscale";
        TS_SERVE_CONFIG = "/config/homebridge.json";
        TS_USERSPACE = "true";
      };
      environmentFiles = [
        "/etc/secrets/ts-homebridge-authkey"
      ];
      volumes = [
        "ts-homebridge-state:/var/lib/tailscale"
        "/etc/tailscale/homebridge.json:/config/homebridge.json:ro"
      ];
      ports = [
        "127.0.0.1:1883:1883" # mosquitto
        "127.0.0.1:8080:8080" # zigbee2mqtt
      ];
      extraOptions = [
        "--add-host=host.containers.internal:host-gateway"
      ];
    };

    homebridge = {
      image = "homebridge/homebridge:2026-02-25";
      dependsOn = [ "ts-homebridge" ];
      environment = {
        TZ = "Europe/Amsterdam";
      };
      volumes = [
        "/srv/homebridge:/homebridge"
      ];
      extraOptions = [
        "--network=host"
      ];
    };

    mosquitto = {
      image = "eclipse-mosquitto:2.0.22";
      dependsOn = [ "ts-homebridge" ];
      volumes = [
        "mosquitto-data:/mosquitto/data"
        "/etc/mosquitto/mosquitto.conf:/mosquitto/config/mosquitto.conf:ro"
      ];
      extraOptions = [
        "--network=container:ts-homebridge"
      ];
    };

    zigbee2mqtt = {
      image = "koenkk/zigbee2mqtt:2.1.3";
      dependsOn = [ "mosquitto" ];
      environment = {
        TZ = "Europe/Amsterdam";
        ZIGBEE2MQTT_CONFIG_FRONTEND_ENABLE = "true";
        ZIGBEE2MQTT_CONFIG_HOMEASSISTANT_ENABLE = "false";
        ZIGBEE2MQTT_CONFIG_MQTT_BASE_TOPIC = "zigbee2mqtt";
        ZIGBEE2MQTT_CONFIG_MQTT_SERVER = "mqtt://localhost:1883";
        ZIGBEE2MQTT_CONFIG_PERMIT_JOIN = "false";
        ZIGBEE2MQTT_CONFIG_SERIAL_ADAPTER = "deconz";
        ZIGBEE2MQTT_CONFIG_SERIAL_BAUDRATE = "115200";
        ZIGBEE2MQTT_CONFIG_SERIAL_PORT = "/dev/ttyUSB0";
        ZIGBEE2MQTT_DATA = "/data";
      };
      volumes = [
        "/srv/zigbee2mqtt:/data"
        "/run/udev:/run/udev:ro"
      ];
      extraOptions = [
        "--network=container:ts-homebridge"
        "--device=/dev/ttyUSB0:/dev/ttyUSB0"
        "--group-add=dialout"
      ];
    };
  };

  networking.firewall = {
    # Allow Tailscale sidecar to reach homebridge UI on the host via the Podman bridge.
    interfaces."podman0".allowedTCPPorts = [ 8581 ];

    # Allow mDNS + HAP (HomeKit Accessory Protocol) for LAN discovery and pairing.
    allowedUDPPorts = [ 5353 ];
    allowedTCPPorts = [ 51826 ];
  };

  environment.etc."tailscale/homebridge.json".text = builtins.toJSON {
    TCP."443".HTTPS = true;
    Web."\${TS_CERT_DOMAIN}:443".Handlers."/".Proxy = "http://host.containers.internal:8581";
  };

  environment.etc."mosquitto/mosquitto.conf".text = ''
    allow_anonymous true
    listener 1883 0.0.0.0
    log_dest stderr
    persistence true
    persistence_location /mosquitto/data/
  '';

  systemd.tmpfiles.rules = [
    "d /srv/homebridge 0755 root root -"
    "d /srv/zigbee2mqtt 0755 root root -"
  ];

  # Make Zigbee USB dongle accessible to containers.
  services.udev.extraRules = ''
    SUBSYSTEM=="tty", ATTRS{interface}=="*", KERNEL=="ttyUSB[0-9]*", MODE="0666"
  '';
}
