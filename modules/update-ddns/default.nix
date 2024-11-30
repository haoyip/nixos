{
  config,
  pkgs,
  ...
}: {
  sops.secrets = {
    "wireguard/b450/endpoint" = {};
    "wireguard/b450/ddns_token" = {};
  };

  systemd.timers."update-ddns" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "5m";
      Unit = "update-ddns.service";
    };
  };

  systemd.services."update-ddns" = {
    script = ''
      set -eu
      ${pkgs.curl}/bin/curl "https://www.duckdns.org/update?domains=$(cat ${config.sops.secrets."wireguard/b450/endpoint".path})&token=$(cat ${config.sops.secrets."wireguard/b450/ddns_token".path})"
    '';

    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
