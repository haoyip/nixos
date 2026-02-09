{pkgs, ...}: {
  programs.yazi = {
    enable = true;

    plugins = {
      inherit (pkgs.yaziPlugins) smart-enter;
    };
  };

  xdg = {
    configFile = {
      "yazi/keymap.toml".source = ./keymap.toml;
      "yazi/theme.toml".source = ./theme.toml;
      "yazi/yazi.toml".source = ./yazi.toml;

      "xdg-desktop-portal-termfilechooser/config" = {
        force = true;
        executable = true;

        text = ''
          [filechooser]
          cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
          default_dir=$HOME
          create_help_file=1
          env=TERMCMD='alacritty --title "File Chooser" --command'
          open_mode=suggested
          save_mode=last
        '';
      };
    };
  };
}
