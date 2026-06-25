{ config, pkgs, ... }:
let
  user = config.system.primaryUser;
  home = "/Users/${user}";
  logDir = "${home}/Library/Logs";
  label = "org.nixos.${user}.icloud-backup";

  swift-scripts = import ../swift-scripts { inherit pkgs; };

  # ---------------------------------------------------------------------------
  # User-editable configuration. Non-secret values only — passwords live in the
  # age-encrypted secrets bundle (see secrets.env.example).
  # ---------------------------------------------------------------------------
  cfg = {
    source = "${home}/Documents"; # iCloud Drive (Desktop & Documents sync)
    repo = "${home}/Local/Backups"; # local restic repo; rclone mirrors this dir

    ageKeyFile = "${home}/.config/sops/age/keys.txt";
    secretsFile = "${home}/.config/icloud-backup/secrets.env.age";

    # NAS endpoints (non-secret). First reachable on tcp/445 wins.
    nasLocalHost = "Unifi-NAS-2.internal";
    smbShare = "Backups"; # SMB share name
    smbPath = "iCloud"; # destination subpath within the share

    # restic retention policy
    keepDaily = 7;
    keepWeekly = 4;
    keepMonthly = 12;
  };

  orchestrator = pkgs.writeShellApplication {
    name = "icloud-backup";

    runtimeInputs = [
      pkgs.age
      pkgs.coreutils
      pkgs.rclone
      pkgs.restic
      swift-scripts.icloud-materialize
    ];

    text = ''
      readonly SOURCE="${cfg.source}"
      readonly REPO="${cfg.repo}"
      readonly AGE_KEY="${cfg.ageKeyFile}"
      readonly SECRETS="${cfg.secretsFile}"
      readonly NAS_LOCAL="${cfg.nasLocalHost}"
      readonly SMB_SHARE="${cfg.smbShare}"
      readonly SMB_PATH="${cfg.smbPath}"

      log() { printf '%s %s\n' "$(date '+%Y-%m-%dT%H:%M:%S')" "$*"; }

      # Paths that need Full Disk Access granted (they read ~/Documents):
      log "icloud-materialize: $(readlink -f "$(command -v icloud-materialize)")"
      log "restic:            $(readlink -f "$(command -v restic)")"

      # --- 1/3: materialise iCloud files (abort if offline + missing) ---------
      log "step 1/3: ensuring iCloud files are on disk under $SOURCE"
      if ! icloud-materialize "$SOURCE"; then
        log "ABORT: iCloud files unavailable and cannot be downloaded (offline?)"
        exit 1
      fi

      # --- decrypt secrets ----------------------------------------------------
      if [ ! -r "$AGE_KEY" ]; then log "ABORT: age key not readable: $AGE_KEY"; exit 1; fi
      if [ ! -r "$SECRETS" ]; then log "ABORT: secrets not readable: $SECRETS"; exit 1; fi

      tmp="$(mktemp -d)"
      chmod 700 "$tmp"
      cleanup() { rm -rf "$tmp"; }
      trap cleanup EXIT

      age --decrypt --identity "$AGE_KEY" --output "$tmp/secrets.env" "$SECRETS"
      # shellcheck source=/dev/null
      source "$tmp/secrets.env"
      # shellcheck disable=SC2154
      : "''${RESTIC_PASSWORD:?missing RESTIC_PASSWORD in secrets}"
      # shellcheck disable=SC2154
      : "''${SMB_USERNAME:?missing SMB_USERNAME in secrets}"
      # shellcheck disable=SC2154
      : "''${SMB_PASSWORD:?missing SMB_PASSWORD in secrets}"

      # --- 2/3: local restic backup (works offline) ---------------------------
      log "step 2/3: restic backup -> $REPO"
      export RESTIC_REPOSITORY="$REPO"
      export RESTIC_PASSWORD

      mkdir -p "$REPO"
      if ! restic cat config >/dev/null 2>&1; then
        log "initialising restic repository"
        restic init
      fi

      restic backup "$SOURCE" --tag icloud --exclude-caches

      log "applying retention policy"
      restic forget --prune \
        --keep-daily ${toString cfg.keepDaily} \
        --keep-weekly ${toString cfg.keepWeekly} \
        --keep-monthly ${toString cfg.keepMonthly}

      # --- 3/3: offsite sync to NAS over SMB (only if reachable) --------------
      log "step 3/3: checking NAS reachability"

      # Use nc without -z (real TCP connect, not scan mode) so the probe matches
      # what rclone actually does. -w 2 = 2s connect timeout. System binary;
      # avoids GNU coreutils timeout which gets sandbox-killed in launchd agents.
      nas_host=""
      if /usr/bin/nc -w 2 "${cfg.nasLocalHost}" 445 </dev/null >/dev/null 2>&1; then
        nas_host="${cfg.nasLocalHost}"
      fi

      if [ -z "$nas_host" ]; then
        log "NAS unreachable on tcp/445 ($NAS_LOCAL); local backup done, skipping offsite sync"
        exit 0
      fi
      log "NAS reachable at $nas_host; syncing"

      # rclone SMB remote configured entirely from env (no rclone.conf on disk).
      export RCLONE_CONFIG_NAS_TYPE="smb"
      export RCLONE_CONFIG_NAS_HOST="$nas_host"
      export RCLONE_CONFIG_NAS_USER="$SMB_USERNAME"
      RCLONE_CONFIG_NAS_PASS="$(rclone obscure "$SMB_PASSWORD")"
      export RCLONE_CONFIG_NAS_PASS

      # NAS sync is best-effort: a failure here must not taint the exit code,
      # since the local restic backup (step 2) already succeeded.
      if rclone sync "$REPO" "NAS:$SMB_SHARE/$SMB_PATH" \
          --transfers 4 \
          --checkers 8 \
          --fast-list \
          --log-level INFO; then
        log "done"
      else
        log "WARN: rclone sync failed (exit $?); local restic backup is intact"
        exit 0
      fi
    '';
  };
in
{
  launchd.user.agents.icloud-backup = {
    command = "${orchestrator}/bin/icloud-backup";

    serviceConfig = {
      Label = label;

      # Triggers: every 4 hours (only fires while the user is logged in).
      RunAtLoad = false;
      StartInterval = 14400;

      # Be a good background citizen.
      ProcessType = "Background";
      LowPriorityIO = true;

      # Logging
      StandardOutPath = "${logDir}/${label}.stdout.log";
      StandardErrorPath = "${logDir}/${label}.stderr.log";
    };
  };
}
