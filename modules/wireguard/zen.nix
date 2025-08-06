{
  config,
  pkgs,
  ...
}: {
  sops.secrets = {
    "wireguard/zen/private_key" = {};
    "wireguard/b450/endpoint" = {};
  };

  networking.firewall.allowedUDPPorts = [51700];

  networking.wg-quick.interfaces = {
    b450 = {
      privateKeyFile = config.sops.secrets."wireguard/zen/private_key".path;

      autostart = true;
      address = ["10.0.0.3/24"];
      listenPort = 51700;

      preUp = ''
        endpoint_host="$(cat ${config.sops.secrets."wireguard/b450/endpoint".path})"

        for i in {1..10}; do
          ip_line=$(${pkgs.getent}/bin/getent hosts "$endpoint_host") && break
          sleep 1
        done

        if [ -z "$ip_line" ]; then
          echo "Failed to resolve endpoint after retries: $endpoint_host"
          exit 1
        fi

        endpoint_ip=$(echo "$ip_line" | ${pkgs.gawk}/bin/awk '{ print $1 }')

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
        endpoint_host="$(cat ${config.sops.secrets."wireguard/b450/endpoint".path})"

        for i in {1..10}; do
          ip_line=$(${pkgs.getent}/bin/getent hosts "$endpoint_host") && break
          sleep 1
        done

        if [ -z "$ip_line" ]; then
          echo "Failed to resolve endpoint after retries: $endpoint_host"
          exit 1
        fi

        endpoint_ip=$(echo "$ip_line" | ${pkgs.gawk}/bin/awk '{ print $1 }')

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
