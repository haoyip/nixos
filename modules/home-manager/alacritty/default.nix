{
  programs.alacritty = {
    enable = true;
  };

  xdg = {
    enable = true;

    configFile."alacritty/alacritty.toml".source = ./alacritty.toml;
    configFile."alacritty/theme/".source = ./theme;
  };
}
