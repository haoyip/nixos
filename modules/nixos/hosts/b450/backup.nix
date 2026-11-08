{pkgs, ...}: let
  hy-snapshot = pkgs.writeShellApplication {
    name = "hy-snapshot";

    runtimeInputs = [
      pkgs.util-linux
      pkgs.btrfs-progs
      pkgs.coreutils
    ];

    text = ''
      flock /run/lock/hy-backup.lock \
        btrfs subvolume snapshot -r \
        /data/8tb_1/HY \
        "/data/8tb_1/HY-snapshots/HY-$(date +%Y%m%d_%H%M%S)"
    '';
  };
in {
  systemd.services.hy-snapshot = {
    unitConfig = {
      # Skip if not mounted
      ConditionPathIsMountPoint = "/data/8tb_1";
    };

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${hy-snapshot}/bin/hy-snapshot";
    };
  };

  systemd.timers.hy-snapshot = {
    wantedBy = ["timers.target"];

    timerConfig = {
      OnCalendar = "05:00";
      Persistent = true;
      OnBootSec = "1min";
    };
  };
}
