{pkgs, username, ...}: {
  environment.systemPackages = [pkgs.btop];

  systemd.tmpfiles.rules = [
    "L+ /home/${username}/.config/btop/btop.conf - - - - ${pkgs.writeText "btop.conf" ''
      color_theme = "tokyo-night"
      theme_background = True
      update_ms = 500
      vim_keys = True
    ''}"
  ];
}
