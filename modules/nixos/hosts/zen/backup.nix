{pkgs, username, ...}: {
  systemd.services.hy-backup = {
    serviceConfig = {
      Type = "oneshot";
      User = username;

      ExecStart = ''
        ${pkgs.rsync}/bin/rsync \
          --archive \
          --verbose \
          --human-readable \
          --delete \
          --rsync-path="flock /run/lock/hy-backup.lock rsync" \
          -e ${pkgs.openssh}/bin/ssh \
          /home/${username}/HY/ \
          b450:/data/8tb_1/HY/
      '';
    };
  };

  systemd.timers.hy-backup = {
    wantedBy = ["timers.target"];

    timerConfig = {
      OnCalendar = "04:00";
      Persistent = true;
      OnBootSec = "1min";
    };
  };
}
