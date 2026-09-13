{lib, ...}: {
  services.opencloud = {
    enable = true;
    url = "https://drive.tingb.xyz";
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
