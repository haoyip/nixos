{
  programs.bat = {
    enable = true;

    config = {
      theme = "catppuccin-frappe";
    };
  };

  xdg = {
    enable = true;

    configFile."bat/themes".source = ./themes;
  };
}
