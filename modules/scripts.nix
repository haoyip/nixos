{
  pkgs,
  ...
}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "nixos-switch" ''
      exec nh os switch . --hostname "$(cat /etc/hostname)" --diff always
    '')

    (pkgs.writeShellScriptBin "nixos-boot" ''
      exec nh os boot . --hostname "$(cat /etc/hostname)" --diff always
    '')
  ];
}
