{pkgs, ...}: {
  environment.systemPackages = [pkgs.jetbrains.datagrip];

  systemd.tmpfiles.rules = [
    "L+ /home/hao/.config/ideavim/ideavimrc - - - - ${./ideavimrc}"
  ];
}
