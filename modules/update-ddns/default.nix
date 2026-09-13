{
  config,
  pkgs,
  ...
}: let
  domain = "tingb.xyz";
in {
  sops.secrets = {
    "porkbun/api_key" = {};
    "porkbun/secret_key" = {};
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
        "https://api.porkbun.com/api/json/v3/dns/editByNameType/${domain}/A" \
        -X POST \
        -H "Content-Type: application/json" \
        -H "X-API-Key: $(cat ${config.sops.secrets."porkbun/api_key".path})" \
        -H "X-Secret-API-Key: $(cat ${config.sops.secrets."porkbun/secret_key".path})" \
        --data "{\"content\": \"$IP\"}"
    '';

    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
