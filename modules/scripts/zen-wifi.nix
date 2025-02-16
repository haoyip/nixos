{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "wifi" ''
      sudo -i -u root bash <<EOF
      systemctl stop iwd
      rfkill block 0 1 2 3
      rfkill unblock 0 1 2 3
      systemctl start iwd
      EOF
    '')
  ];
}
