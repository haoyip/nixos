{
  services.samba = {
    enable = true;
    openFirewall = true;

    settings = {
      global = {
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.0. 10.0.0. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
        "store dos attributes" = "no";
      };

      "media" = {
        "path" = "/data/8tb_1/media/";
        "public" = "yes";
        "writable" = "no";
      };

      "media-write" = {
        "path" = "/data/8tb_1/media/";
        "valid users" = "hao";
        "public" = "no";
        "writable" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force create mode" = "0644";
        "force directory mode" = "0755";
        "browseable" = "no";
      };

      "home" = {
        "path" = "/home/hao";
        "valid users" = "hao";
        "public" = "no";
        "writable" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force create mode" = "0644";
        "force directory mode" = "0755";
        "browseable" = "no";
      };

      "HY" = {
        "path" = "/data/8tb_1/HY/";
        "valid users" = "hao";
        "public" = "no";
        "writable" = "yes";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force create mode" = "0644";
        "force directory mode" = "0755";
        "browseable" = "no";
      };
    };
  };
}
