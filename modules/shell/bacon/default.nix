{pkgs, ...}: {
  environment.systemPackages = [pkgs.bacon];

  systemd.tmpfiles.rules = [
    "L+ /home/hao/.config/bacon/prefs.toml - - - - ${./prefs.toml}"
  ];
}
