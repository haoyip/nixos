{
  programs.starship = {
    enable = true;
  };

  xdg = {
    enable = true;

    configFile."starship.toml".source = ./starship.toml;
  };
}
