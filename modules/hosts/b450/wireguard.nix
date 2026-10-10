{
  pkgs,
  config,
  ...
}: {
  sops.secrets = {
    "wireguard/b450/private_key" = {};
  };

  networking.nat.enable = true;
  networking.nat.externalInterface = "enp37s0";
  networking.nat.internalInterfaces = ["wg0"];

  networking.firewall.allowedUDPPorts = [51700];

  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv4.conf.wg0.forwarding" = 1;
    "net.ipv4.conf.enp37s0.forwarding" = 1;
  };

  networking.wg-quick.interfaces = {
    wg0 = {
      privateKeyFile = config.sops.secrets."wireguard/b450/private_key".path;

      address = ["10.0.0.1/24"];
      listenPort = 51700;

      postUp = ''
        ${pkgs.iptables}/bin/iptables -A FORWARD -i %i -j ACCEPT;
        ${pkgs.iptables}/bin/iptables -A FORWARD -o %i -j ACCEPT;
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -o enp37s0 -j MASQUERADE
      '';

      postDown = ''
        ${pkgs.iptables}/bin/iptables -D FORWARD -i %i -j ACCEPT;
        ${pkgs.iptables}/bin/iptables -D FORWARD -o %i -j ACCEPT;
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -o enp37s0 -j MASQUERADE
      '';

      peers = [
        {
          # zen
          publicKey = "0YCmPFsF9bT7V6ETehjdMvkagEak1VTePmgCicXQl2w=";
          allowedIPs = ["10.0.0.3/32"];
        }
        {
          # tt
          publicKey = "SJtnhxvSPzkn2kAsopjvslPU0kH2oyW0U2ZZR/7Qry0=";
          allowedIPs = ["10.0.0.10/32"];
        }
        {
          # p9
          publicKey = "tEusjLDr+G+/hxX08TY5QeQLmPUKJwEGBGErwp2cjW4=";
          allowedIPs = ["10.0.0.11/32"];
        }
      ];
    };
  };
}
