{pkgs, ...}: {
  systemd.services.backup = {
    description = "rsync backup";

    serviceConfig = {
      Type = "oneshot";
      User = "hao";

      ExecStart = ''
        ${pkgs.rsync}/bin/rsync \
          --archive \
          --verbose \
          --human-readable \
          --delete \
          --rsync-path="flock /run/lock/hy-backup.lock rsync" \
          -e ${pkgs.openssh}/bin/ssh \
          /home/hao/HY/ \
          b450:/data/8tb_1/HY/
      '';
    };
  };

  systemd.timers.backup = {
    description = "rsync backup timers";

    wantedBy = ["timers.target"];

    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "24h";
      Persistent = true;
    };
  };
}
