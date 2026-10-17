{pkgs, username, ...}: {
  environment.systemPackages = [pkgs.kitty];

  systemd.tmpfiles.rules = [
    "L+ /home/${username}/.config/kitty/kitty.conf - - - - ${./kitty.conf}"
  ];
}
