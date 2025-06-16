{
  programs.bacon = {
    enable = true;
  };

  xdg = {
    enable = true;

    configFile."bacon/prefs.toml".source = ./prefs.toml;
  };
}
