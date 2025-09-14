{config, ...}: let
  domain = "lelezhu.lol";
  tls = "tls ${config.sops.secrets."home/origin_server/crt".path} ${config.sops.secrets."home/origin_server/key".path}";
in {
  sops.secrets = {
    "home/origin_server/crt" = {
      owner = "caddy";
    };

    "home/origin_server/key" = {
      owner = "caddy";
    };
  };

  services.caddy = {
    enable = true;

    virtualHosts."pic.${domain}" = {
      extraConfig = ''
        ${tls}
        reverse_proxy localhost:2283
      '';
    };

    virtualHosts."tv.${domain}" = {
      extraConfig = ''
        ${tls}
        reverse_proxy localhost:8096
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [443];
}
