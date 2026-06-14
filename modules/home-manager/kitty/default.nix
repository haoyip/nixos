{
  programs.kitty = {
    enable = true;
  };

  xdg = {
    enable = true;

    configFile."kitty/kitty.conf".source = ./kitty.conf;
  };
}
