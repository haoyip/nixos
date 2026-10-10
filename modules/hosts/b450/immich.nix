{lib, ...}: let
  mediaLocation = "/data/8tb_1/immich";
in {
  services.immich = {
    enable = true;
    host = "0.0.0.0";
    port = 2283;
    mediaLocation = "${mediaLocation}";

    # `null` will give access to all devices.
    accelerationDevices = null;
  };

  networking.firewall.allowedTCPPorts = [2283];

  systemd.tmpfiles.rules = [
    "d ${mediaLocation} 0750 immich immich -"
  ];

  users.users.immich.extraGroups = ["video" "render"];

  systemd.services.immich-server = {
    wantedBy = lib.mkForce [];
  };

  systemd.services.immich-machine-learning = {
    wantedBy = lib.mkForce [];
  };
}
