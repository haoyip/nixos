{
  config,
  domain,
  pkgs,
  ...
}: let
  publicKey = "z9kZBdl+8fdYX0I/gqDHTShrsv7OGwMCm6V5hyXutno=";
in {
  sops.secrets = {
    "wireguard/zen/private_key" = {};

    "porkbun/api_key" = {};
    "porkbun/secret_key" = {};
  };

  networking.firewall.allowedUDPPorts = [51700];

  networking.resolvconf.extraOptions = ["timeout:1" "attempts:1"];

  # openresolv treats 127.0.0.1 as a "local nameserver" and, with the default
  # resolv_conf_local_only=YES, orders it first and drops the following
  # non-local nameserver (10.0.0.1). Clear the list so the wg `dns` order
  # (10.0.0.1 then 127.0.0.1) is preserved.
  networking.resolvconf.extraConfig = "local_nameservers=";

  networking.wg-quick.interfaces = {
    b450 = {
      privateKeyFile = config.sops.secrets."wireguard/zen/private_key".path;

      autostart = true;
      address = ["10.0.0.3/24"];
      listenPort = 51700;
      dns = ["10.0.0.1" "127.0.0.1"];

      preUp = ''
        endpoint_ip=$(
          ${pkgs.curl}/bin/curl -fsSL \
            "https://api.porkbun.com/api/json/v3/dns/retrieveByNameType/${domain}/A" \
            -H "X-API-Key: $(cat ${config.sops.secrets."porkbun/api_key".path})" \
            -H "X-Secret-API-Key: $(cat ${config.sops.secrets."porkbun/secret_key".path})" \
            | ${pkgs.jaq}/bin/jaq -r '.records[0].content'
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

        wg set b450 peer ${publicKey} endpoint "$endpoint_ip:51700"
      '';

      peers = [
        {
          publicKey = publicKey;
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
      dns = ["10.0.0.1"];

      preUp = ''
        endpoint_ip=$(
          ${pkgs.curl}/bin/curl -fsSL \
            "https://api.porkbun.com/api/json/v3/dns/retrieveByNameType/${domain}/A" \
            -H "X-API-Key: $(cat ${config.sops.secrets."porkbun/api_key".path})" \
            -H "X-Secret-API-Key: $(cat ${config.sops.secrets."porkbun/secret_key".path})" \
            | ${pkgs.jaq}/bin/jaq -r '.records[0].content'
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

        wg set b450-all peer ${publicKey} endpoint "$endpoint_ip:51700"
      '';

      peers = [
        {
          publicKey = publicKey;
          allowedIPs = ["0.0.0.0/0"];

          # Send keepalives every 25 seconds. Important to keep NAT tables alive.
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
