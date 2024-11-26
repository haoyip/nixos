{config, ...}: {
  sops.secrets = {
    "wireguard/mate/private_key" = {};
    "wireguard/b450/endpoint" = {};
  };

  networking.firewall.allowedUDPPorts = [51700];

  networking.wg-quick.interfaces = {
    wg0 = {
      privateKeyFile = config.sops.secrets."wireguard/mate/private_key".path;

      address = ["10.0.0.2/24"];
      listenPort = 51700;

      postUp = ''
        wg set wg0 peer z9kZBdl+8fdYX0I/gqDHTShrsv7OGwMCm6V5hyXutno= \
        endpoint "$(cat ${config.sops.secrets."wireguard/b450/endpoint".path}):51700"
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
