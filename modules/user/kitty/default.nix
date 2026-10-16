{pkgs, ...}: {
  environment.systemPackages = [pkgs.kitty];

  systemd.tmpfiles.rules = [
    "L+ /home/hao/.config/kitty/kitty.conf - - - - ${./kitty.conf}"
  ];
}
