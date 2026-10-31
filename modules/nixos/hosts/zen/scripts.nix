{
  config,
  pkgs,
  username,
  ...
}: let
  macB450 = config.sops.secrets."mac/b450".path;

  gp1Gateway = config.sops.secrets."gp-1/gateway".path;
in {
  sops.secrets = {
    "home/samba/${username}" = {owner = username;};

    "mac/b450" = {
      owner = username;
    };

    "gp-1/gateway" = {owner = username;};
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "wake-b450" ''
      exec wakeonlan "$(cat ${macB450})"
    '')

    (pkgs.writeShellScriptBin "gp-1" ''
      gateway="$(cat ${gp1Gateway})"

      exec sudo gpclient connect "$gateway" --as-gateway
    '')

    (pkgs.writeShellScriptBin "vpn-b450" ''
      sudo -i -u root bash <<EOF
      set -e

      if systemctl is-active --quiet wg-quick-b450-all.service; then
        systemctl stop wg-quick-b450-all.service
        systemctl start wg-quick-b450.service

        echo 'vpn stopped'
      else
        systemctl stop wg-quick-b450.service
        systemctl start wg-quick-b450-all.service

        echo 'vpn started'
      fi
      EOF
    '')

    (pkgs.writeShellScriptBin "mount-media" ''
      sudo mkdir -p /mnt/media
      sudo mount -t cifs //192.168.0.100/media-write /mnt/media -o username=${username},password=$(cat ${config.sops.secrets."home/samba/${username}".path}),uid=1000,gid=1000
    '')

    (pkgs.writeShellScriptBin "mount-media-remote" ''
      sudo mkdir -p /mnt/media
      sudo mount -t cifs //10.0.0.1/media-write /mnt/media -o username=${username},password=$(cat ${config.sops.secrets."home/samba/${username}".path}),uid=1000,gid=1000
    '')

    (pkgs.writeShellScriptBin "mount-hy" ''
      sudo mkdir -p /mnt/HY
      sudo mount -t cifs //192.168.0.100/HY /mnt/HY -o username=${username},password=$(cat ${config.sops.secrets."home/samba/${username}".path}),uid=1000,gid=1000
    '')

    (pkgs.writeShellScriptBin "mount-hy-remote" ''
      sudo mkdir -p /mnt/HY
      sudo mount -t cifs //10.0.0.1/HY /mnt/HY -o username=${username},password=$(cat ${config.sops.secrets."home/samba/${username}".path}),uid=1000,gid=1000
    '')
  ];
}
