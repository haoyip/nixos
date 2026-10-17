{pkgs, username, ...}: {
  environment.systemPackages = [pkgs.bacon];

  systemd.tmpfiles.rules = [
    "L+ /home/${username}/.config/bacon/prefs.toml - - - - ${./prefs.toml}"
  ];
}
