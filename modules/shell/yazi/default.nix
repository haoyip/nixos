{
  pkgs,
  username,
  ...
}: let
  termfilechooserConfig = pkgs.writeText "termfilechooser-config" ''
    [filechooser]
    cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    default_dir=$HOME
    env=TERMCMD='ghostty --title="File Chooser" -e'
    open_mode=suggested
    save_mode=last
  '';

  yaziDesktop = pkgs.makeDesktopItem {
    name = "yazi";
    desktopName = "Yazi";
    genericName = "File Manager";
    exec = "ghostty -e yazi";
    terminal = false;
    categories = ["System" "FileTools" "FileManager"];
    mimeTypes = ["inode/directory"];
    icon = "${./yazi.png}";
  };
in {
  environment.systemPackages = [
    pkgs.yazi
    yaziDesktop
  ];

  systemd.tmpfiles.rules = [
    "L+ /home/${username}/.config/yazi/keymap.toml - - - - ${./keymap.toml}"
    "L+ /home/${username}/.config/yazi/theme.toml - - - - ${./theme.toml}"
    "L+ /home/${username}/.config/yazi/yazi.toml - - - - ${./yazi.toml}"
    "L+ /home/${username}/.config/yazi/plugins/smart-enter.yazi - - - - ${pkgs.yaziPlugins.smart-enter}"
    "L+ /home/${username}/.config/xdg-desktop-portal-termfilechooser/config - - - - ${termfilechooserConfig}"
  ];
}
