{
  programs.foot = {
    enable = true;
  };

  xdg = {
    enable = true;

    configFile."foot/foot.ini".source = ./foot.ini;
    configFile."foot/themes/".source = ./themes;
  };
}
