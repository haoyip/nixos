{
  config,
  lib,
  pkgs,
  username,
  ...
}: let
  dataDir = "/data/8tb_1/anki-sync-server";
  serviceUser = "anki-sync-server";
in {
  sops.secrets."home/app/hao" = {};

  services.anki-sync-server = {
    enable = true;

    address = "127.0.0.1";
    port = 27701;
    baseDirectory = dataDir;

    users = [
      {
        username = username;
        passwordFile = config.sops.secrets."home/app/hao".path;
      }
    ];
  };

  users.groups.${serviceUser} = {};

  users.users.${serviceUser} = {
    isSystemUser = true;
    group = serviceUser;
    home = dataDir;
  };

  systemd.services.anki-sync-server = {
    wantedBy = lib.mkForce [];

    unitConfig.ConditionPathIsMountPoint = "/data/8tb_1";

    serviceConfig = {
      # DynamicUser cannot own the existing data directory on the disk.
      DynamicUser = lib.mkForce false;
      User = serviceUser;
      Group = serviceUser;

      ExecStartPre = [
        "+${pkgs.coreutils}/bin/install -d -o ${serviceUser} -g ${serviceUser} -m 0750 ${dataDir}"
      ];
    };
  };
}
