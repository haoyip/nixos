{pkgs, username, ...}: {
  environment.systemPackages = [pkgs.jetbrains.datagrip];

  systemd.tmpfiles.rules = [
    "L+ /home/${username}/.config/ideavim/ideavimrc - - - - ${./ideavimrc}"
  ];
}
