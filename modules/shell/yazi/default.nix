{pkgs, ...}: let
  termfilechooserConfig = pkgs.writeText "termfilechooser-config" ''
    [filechooser]
    cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    default_dir=$HOME
    env=TERMCMD='kitty -T "File Chooser"'
    open_mode=suggested
    save_mode=last
  '';

  yaziDesktop = pkgs.makeDesktopItem {
    name = "yazi";
    desktopName = "Yazi";
    genericName = "File Manager";
    exec = "kitty yazi";
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
    "L+ /home/hao/.config/yazi/keymap.toml - - - - ${./keymap.toml}"
    "L+ /home/hao/.config/yazi/theme.toml - - - - ${./theme.toml}"
    "L+ /home/hao/.config/yazi/yazi.toml - - - - ${./yazi.toml}"
    "L+ /home/hao/.config/yazi/plugins/smart-enter.yazi - - - - ${pkgs.yaziPlugins.smart-enter}"
    "L+ /home/hao/.config/xdg-desktop-portal-termfilechooser/config - - - - ${termfilechooserConfig}"
  ];
}
