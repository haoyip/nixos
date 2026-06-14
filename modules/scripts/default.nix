{
  config,
  pkgs,
  ...
}: let
  macB450 = config.sops.secrets."mac/b450".path;

  gp1Gateway = config.sops.secrets."gp-1/gateway".path;
  gp1User = config.sops.secrets."gp-1/user".path;
  gp1Pass = config.sops.secrets."gp-1/password".path;

  gp2Gateway = config.sops.secrets."gp-2/gateway".path;
  gp2User = config.sops.secrets."gp-2/user".path;
  gp2Pass = config.sops.secrets."gp-2/password".path;
in {
  sops.secrets = {
    "mac/b450" = {
      owner = "hao";
    };

    "gp-1/gateway" = {owner = "hao";};
    "gp-1/user" = {owner = "hao";};
    "gp-1/password" = {owner = "hao";};

    "gp-2/gateway" = {owner = "hao";};
    "gp-2/user" = {owner = "hao";};
    "gp-2/password" = {owner = "hao";};
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "nixos-switch" ''
      exec nh os switch . --hostname "$(cat /etc/hostname)" --diff always
    '')

    (pkgs.writeShellScriptBin "nixos-boot" ''
      exec nh os boot . --hostname "$(cat /etc/hostname)" --diff always
    '')

    (pkgs.writeShellScriptBin "wake-b450" ''
      exec wakeonlan "$(cat ${macB450})"
    '')

    (pkgs.writeShellScriptBin "gp-1" ''
      gateway="$(cat ${gp1Gateway})"
      user="$(cat ${gp1User})"
      pass="$(cat ${gp1Pass})"

      exec sudo gpclient connect "$gateway" \
        -u "$user" \
        --passwd-on-stdin \
        --as-gateway <<< "$pass"
    '')

    (pkgs.writeShellScriptBin "gp-2" ''
      gateway="$(cat ${gp2Gateway})"
      user="$(cat ${gp2User})"
      pass="$(cat ${gp2Pass})"

      exec sudo gpclient connect "$gateway" \
        -u "$user" \
        --passwd-on-stdin \
        --as-gateway <<< "$pass"
    '')
  ];
}
