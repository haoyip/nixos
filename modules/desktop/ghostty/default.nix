{
  pkgs,
  username,
  ...
}: {
  environment.systemPackages = [pkgs.ghostty];

  systemd.tmpfiles.rules = [
    "L+ /home/${username}/.config/ghostty/config.ghostty - - - - ${./config.ghostty}"
    "L+ /home/${username}/.config/ghostty/cursor_warp.glsl - - - - ${./cursor_warp.glsl}"
  ];
}
