{
  config,
  pkgs,
  ...
}: {
  sops.secrets = {
    "wireguard/zen/private_key" = {};

    "home/ddns/zone_id" = {};
    "home/ddns/record_id" = {};
    "home/ddns/api_token" = {};
  };

  networking.firewall.allowedUDPPorts = [51700];

  networking.wg-quick.interfaces = {
    b450 = {
      privateKeyFile = config.sops.secrets."wireguard/zen/private_key".path;

      autostart = true;
      address = ["10.0.0.3/24"];
      listenPort = 51700;

      preUp = ''
        endpoint_ip=$(
          ${pkgs.curl}/bin/curl "https://api.cloudflare.com/client/v4/zones/$(cat ${config.sops.secrets."home/ddns/zone_id".path})/dns_records/$(cat ${config.sops.secrets."home/ddns/record_id".path})" \
            -H "Authorization: Bearer $(cat ${config.sops.secrets."home/ddns/api_token".path})" \
            | ${pkgs.jaq}/bin/jaq .result.content \
            | tr -d '"'
        )

        echo "$endpoint_ip" > /tmp/wg-b450-endpoint-ip
      '';

      postUp = ''
        if [ ! -f /tmp/wg-b450-endpoint-ip ]; then
          echo "Missing resolved IP file /tmp/wg-b450-endpoint-ip"
          exit 1
        fi

        endpoint_ip=$(cat /tmp/wg-b450-endpoint-ip)

        echo "$endpoint_ip"

        wg set b450 peer z9kZBdl+8fdYX0I/gqDHTShrsv7OGwMCm6V5hyXutno= endpoint "$endpoint_ip:51700"
      '';

      peers = [
        {
          publicKey = "z9kZBdl+8fdYX0I/gqDHTShrsv7OGwMCm6V5hyXutno=";
          allowedIPs = ["10.0.0.0/24"];

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };

    b450-all = {
      privateKeyFile = config.sops.secrets."wireguard/zen/private_key".path;

      autostart = false;
      address = ["10.0.0.3/24"];
      listenPort = 51700;

      preUp = ''
        endpoint_ip=$(
          ${pkgs.curl}/bin/curl "https://api.cloudflare.com/client/v4/zones/$(cat ${config.sops.secrets."home/ddns/zone_id".path})/dns_records/$(cat ${config.sops.secrets."home/ddns/record_id".path})" \
            -H "Authorization: Bearer $(cat ${config.sops.secrets."home/ddns/api_token".path})" \
            | ${pkgs.jaq}/bin/jaq .result.content \
            | tr -d '"'
        )

        echo "$endpoint_ip" > /tmp/wg-b450-endpoint-ip
      '';

      postUp = ''
        if [ ! -f /tmp/wg-b450-endpoint-ip ]; then
          echo "Missing resolved IP file /tmp/wg-b450-endpoint-ip"
          exit 1
        fi

        endpoint_ip=$(cat /tmp/wg-b450-endpoint-ip)

        echo "$endpoint_ip"

        wg set b450-all peer z9kZBdl+8fdYX0I/gqDHTShrsv7OGwMCm6V5hyXutno= endpoint "$endpoint_ip:51700"
      '';

      peers = [
        {
          publicKey = "z9kZBdl+8fdYX0I/gqDHTShrsv7OGwMCm6V5hyXutno=";
          allowedIPs = ["0.0.0.0/0"];

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
