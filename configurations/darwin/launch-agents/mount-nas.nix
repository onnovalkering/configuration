{ config, pkgs, ... }:

let
  logDir = "/Users/${user}/Library/Logs";
  serviceLabel = "org.nixos.onno.mount-nas";
  tailscaleBin = "/opt/homebrew/bin/tailscale";
  user = config.system.primaryUser;

  mountNasScript = pkgs.writeShellScript "mount-nas-script" ''
    set -euo pipefail

    SMB_ADDRESS="smb://server-consus/Share"
    MOUNT_POINT="/Volumes/Share"

    # 1. Connectivity Check (Tailscale)
    IS_TS=1
    if ${tailscaleBin} status >/dev/null 2>&1; then IS_TS=0; fi

    if [ $IS_TS -ne 0 ]; then
      echo "$(date): No Tailscale connection detected. Exiting."
      exit 0
    fi

    # 2. Duplicate Mount Check
    if /sbin/mount | /usr/bin/grep -q "$MOUNT_POINT"; then
      echo "$(date): $MOUNT_POINT is already mounted. Nothing to do."
      exit 0
    fi

    # 3. The Actual Mount
    echo "$(date): Environment ready. Attempting to mount $SMB_ADDRESS..."

    # osascript uses the user's Keychain for credentials
    if /usr/bin/osascript -e "mount volume \"$SMB_ADDRESS\"" >/dev/null 2>&1; then
      echo "$(date): Successfully mounted $SMB_ADDRESS."
      
      # Give the OS a moment to register the mount.
      sleep 2

      # KICK FINDER: Update the sidebar/view now that the mount is successful
      /usr/bin/osascript -e 'tell application "Finder" to try; update (POSIX file "/Volumes") as alias; end try' >/dev/null 2>&1
    else
      echo "$(date): ERROR: Mount failed: $SMB_ADDRESS." >&2
      exit 1
    fi
  '';
in
{
  launchd.user.agents.nas-mount = {
    serviceConfig = {
      Label = serviceLabel;
      ProgramArguments = [ "${mountNasScript}" ];

      # Triggers
      RunAtLoad = true;
      StartInterval = 600;
      WatchPaths = [ "/Library/Preferences/SystemConfiguration" ];

      # Logging
      StandardOutPath = "${logDir}/${serviceLabel}.stdout.log";
      StandardErrorPath = "${logDir}/${serviceLabel}.stderr.log";
    };
  };
}
