{ pkgs, ... }:
let
  logDir = "/Library/Logs";
  label = "org.pqrs.Karabiner-VirtualHIDDevice-Daemon";
  karabinerAppRoot = "${pkgs.karabiner-dk}/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications";
  karabinerDaemonBundle = "${karabinerAppRoot}/Karabiner-VirtualHIDDevice-Daemon.app";
  karabinerDaemonBin = "${karabinerDaemonBundle}/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon";
in
{
  environment.systemPackages = [ pkgs.karabiner-dk ];

  launchd.daemons.karabiner-virtual-hid = {
    serviceConfig = {
      Label = label;
      ProgramArguments = [
        "/bin/sh"
        "-c"
        "/bin/wait4path /nix/store && exec \"${karabinerDaemonBin}\""
      ];

      # Triggers
      RunAtLoad = true;
      KeepAlive = true;

      # Logging
      StandardOutPath = "${logDir}/${label}.stdout.log";
      StandardErrorPath = "${logDir}/${label}.stderr.log";
    };
  };
}
