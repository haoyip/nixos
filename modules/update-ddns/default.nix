{
  config,
  pkgs,
  ...
}: {
  sops.secrets = {
    "home/ddns/zone_id" = {};
    "home/ddns/record_id" = {};
    "home/ddns/api_token" = {};
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

      IP="$(${pkgs.curl}/bin/curl -4fsSL https://api.ipify.org)"

      ${pkgs.curl}/bin/curl -fsSL \
        "https://api.cloudflare.com/client/v4/zones/$(cat ${config.sops.secrets."home/ddns/zone_id".path})/dns_records/$(cat ${config.sops.secrets."home/ddns/record_id".path})" \
        -X PATCH \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $(cat ${config.sops.secrets."home/ddns/api_token".path})" \
        --data "{\"content\": \"$IP\"}"
    '';

    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
