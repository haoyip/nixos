{pkgs, ...}: {
  sops.secrets = {
    "wireguard/b450/private_key" = {
      path = "/sops/wireguard/b450.txt";
      owner = "root";
    };
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
      privateKeyFile = "/sops/wireguard/b450.txt";

      address = ["10.0.0.1/24"];
      listenPort = 51700;

      # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
      # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
      postUp = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o enp37s0 -j MASQUERADE
      '';

      # This undoes the above command
      postDown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.0.0.0/24 -o enp37s0 -j MASQUERADE
      '';

      peers = [
        {
          # mate
          publicKey = "U28aes2XdMRnnhYFWcvDDly/eWUm/VLE7o13kFdGRFU=";
          allowedIPs = ["10.0.0.2/32"];
        }
      ];
    };
  };
}
