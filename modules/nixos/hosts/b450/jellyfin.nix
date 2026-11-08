{
  lib,
  pkgs,
  ...
}: {
  services.jellyfin = {
    enable = true;
  };

  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

  systemd.services.jellyfin = {
    wantedBy = lib.mkForce [];
  };
}
