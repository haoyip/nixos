{pkgs, ...}: {
  environment.systemPackages = [
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
  ];
}
