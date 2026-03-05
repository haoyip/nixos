{
  xdg = {
    enable = true;

    configFile."niri/binds-app.kdl".source = ./binds-app.kdl;
    configFile."niri/binds-noctalia.kdl".source = ./binds-noctalia.kdl;
    configFile."niri/binds-volume-brightness.kdl".source = ./binds-volume-brightness.kdl;
    configFile."niri/binds.kdl".source = ./binds.kdl;
    configFile."niri/config.kdl".source = ./config.kdl;
    configFile."niri/window-rule.kdl".source = ./window-rule.kdl;
  };
}
