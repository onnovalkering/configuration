{ config, pkgs, ... }:
let
  logDir = "/Users/${user}/Library/Logs";
  prefix = "org.nixos.${user}.kanata";
  user = config.system.primaryUser;

  swift-scripts = import ../swift-scripts { inherit pkgs; };

  mkKanataDaemon =
    { name }:
    let
      label = "${prefix}-${name}";
    in
    {
      command = "${pkgs.kanata}/bin/kanata --cfg /Users/${user}/.config/kanata/${name}.kbd";
      serviceConfig = {
        Label = label;

        # Triggers
        RunAtLoad = true;
        KeepAlive = false;

        # Logging
        StandardOutPath = "${logDir}/${label}.stdout.log";
        StandardErrorPath = "${logDir}/${label}.stderr.log";
      };
    };

  mkKanataDeviceWatcher =
    { device, name }:
    let
      label = "${prefix}-${name}-watcher";
    in
    {
      command = "${swift-scripts.usb-watcher}/bin/usb-watcher '${device}' --kickstart 'system/${prefix}-${name}'";
      serviceConfig = {
        Label = label;

        # Triggers
        RunAtLoad = true;
        KeepAlive = true;

        # Logging
        StandardOutPath = "${logDir}/${label}.stdout.log";
        StandardErrorPath = "${logDir}/${label}.stderr.log";
      };
    };
in
{
  environment.systemPackages = [ pkgs.kanata ];

  launchd.daemons = {
    # Define a separate daemon for each keyboard.
    kanata-internal = mkKanataDaemon { name = "internal"; };
    kanata-mx-keys = mkKanataDaemon { name = "mx-keys"; };

    # Define a watcher daemon to trigger reload when MX Keys reconnects.
    kanata-mx-keys-watcher = mkKanataDeviceWatcher {
      name = "mx-keys";
      device = "USB Receiver";
    };
  };
}
