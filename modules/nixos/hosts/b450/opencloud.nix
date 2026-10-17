{
  domain,
  lib,
  pkgs,
  ...
}: {
  services.opencloud = {
    enable = true;
    package = pkgs.opencloud;
    url = "https://drive.${domain}";
    address = "localhost";
    port = 9200;
    stateDir = "/data/8tb_1/opencloud";

    environment = {
      PROXY_TLS = "false";
      IDM_ADMIN_PASSWORD = "password";
    };
  };

  systemd.services.opencloud = {
    wantedBy = lib.mkForce [];
  };
}
