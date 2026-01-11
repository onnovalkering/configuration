{ config, pkgs, ... }:
let
  logDir = "/Users/${user}/Library/Logs";
  prefix = "org.nixos.${user}.kanata";
  user = config.system.primaryUser;

  mkKanataDaemon =
    name:
    let
      label = "${prefix}-${name}";
    in
    {
      command = "${pkgs.kanata}/bin/kanata --cfg /Users/${user}/.config/kanata/${name}.kbd";
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

  # Define a seperate deamon for each keyboard.
  launchd.daemons.kanata-internal = mkKanataDaemon "internal";
  launchd.daemons.kanata-mx-keys = mkKanataDaemon "mx-keys";
}
