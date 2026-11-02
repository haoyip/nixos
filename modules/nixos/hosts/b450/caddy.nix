{
  config,
  domain,
  pkgs,
  ...
}: {
  sops.secrets = {
    "porkbun/api_key" = {
      owner = "caddy";
    };

    "porkbun/secret_key" = {
      owner = "caddy";
    };
  };

  sops.templates."caddy-env".content = ''
    PORKBUN_API_KEY=${config.sops.placeholder."porkbun/api_key"}
    PORKBUN_SECRET_KEY=${config.sops.placeholder."porkbun/secret_key"}
  '';

  systemd.services.caddy.serviceConfig.EnvironmentFile =
    config.sops.templates."caddy-env".path;

  services.caddy = {
    enable = true;

    package = pkgs.caddy.withPlugins {
      plugins = ["github.com/caddy-dns/porkbun@v0.3.1"];
      hash = "sha256-3XnnBdOW8A+LmmcqR94v1ZkyMoMB3EfBWFv0uBzz4cA=";
    };

    globalConfig = ''
      acme_dns porkbun {
        api_key {env.PORKBUN_API_KEY}
        api_secret_key {env.PORKBUN_SECRET_KEY}
      }
    '';

    virtualHosts."pic.${domain}" = {
      extraConfig = ''
        reverse_proxy localhost:2283
      '';
    };

    virtualHosts."tv.${domain}" = {
      extraConfig = ''
        reverse_proxy localhost:8096
      '';
    };

    virtualHosts."drive.${domain}" = {
      extraConfig = ''
        reverse_proxy localhost:9200
      '';
    };

    virtualHosts."vault.${domain}" = {
      extraConfig = ''
        encode zstd gzip

        reverse_proxy :${toString config.services.vaultwarden.config.ROCKET_PORT} {
            header_up X-Real-IP {remote_host}
        }
      '';
    };
  };

  networking.firewall.interfaces.wg0.allowedTCPPorts = [443];
}
