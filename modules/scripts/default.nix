{
  config,
  pkgs,
  ...
}: {
  sops.secrets = {
    "mac/b450" = {
      owner = "hao";
    };
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "nixos-switch" ''
      nh os switch . --hostname $(cat /etc/hostname) --diff always
    '')

    (pkgs.writeShellScriptBin "nixos-boot" ''
      nh os boot . --hostname $(cat /etc/hostname) --diff always
    '')

    (pkgs.writeShellScriptBin "wake-b450" ''
      wakeonlan $(cat ${config.sops.secrets."mac/b450".path})
    '')
  ];
}
