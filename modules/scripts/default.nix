{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "nixos-switch" ''
      nh os switch . --hostname $(cat /etc/hostname)
    '')
  ];
}
