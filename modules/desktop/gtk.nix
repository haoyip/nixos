{pkgs, ...}: let
  settings = ''
    [Settings]
    gtk-cursor-theme-name=Bibata-Modern-Ice
    gtk-cursor-theme-size=32
    gtk-icon-theme-name=Tela
  '';

  settingsFile = pkgs.writeText "gtk-settings.ini" settings;
in {
  environment = {
    systemPackages = with pkgs; [
      bibata-cursors
      tela-icon-theme
    ];

    sessionVariables = {
      XCURSOR_THEME = "Bibata-Modern-Ice";
      XCURSOR_SIZE = "32";
    };
  };

  systemd.tmpfiles.rules = [
    "L+ /home/hao/.config/gtk-3.0/settings.ini - - - - ${settingsFile}"
    "L+ /home/hao/.config/gtk-4.0/settings.ini - - - - ${settingsFile}"
  ];
}
