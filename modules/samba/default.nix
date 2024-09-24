{
  services.samba = {
    enable = true;
    openFirewall = true;

    settings = {
      "media" = {
        "path" = "/data/8tb_1/media/";
        "public" = "yes";
        "writable" = "no";
      };
    };
  };
}
