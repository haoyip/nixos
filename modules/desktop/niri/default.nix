{
  pkgs,
  username,
  ...
}: {
  environment.defaultPackages = with pkgs; [
    bibata-cursors
    brightnessctl
    hyprpicker
    niri
    noctalia
    xdg-utils
    xwayland-satellite
  ];

  services.greetd = {
    enable = true;

    settings = {
      initial_session = {
        command = "niri-session";
        user = username;
      };

      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd niri-session";
      };
    };
  };

  environment.variables = {
    DISPLAY = ":0";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "gtk3";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_CURRENT_SESSION = "niri";
    XDG_SESSION_TYPE = "wayland";
  };

  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-termfilechooser
    ];

    config.niri = {
      default = ["termfilechooser" "gnome" "gtk"];

      "org.freedesktop.impl.portal.FileChooser" = ["termfilechooser"];
    };
  };

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  # Switch power profile when AC is plugged/unplugged
  services.udev.extraRules = ''
    SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", \
      RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance"

    SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", \
      RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set balanced"
  '';

  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "toggle-laptop-output" ''
      if [[ $(niri msg --json outputs | ${pkgs.jaq}/bin/jaq '."eDP-1".current_mode == null') == "true" ]]; then
        niri msg output eDP-1 on
      else
        niri msg output eDP-1 off
      fi
    '')

    (pkgs.writeShellScriptBin "lock-if-only-laptop" ''
      if [ "$(niri msg outputs | grep "^Output" | wc -l)" -eq 1 ]; then
        noctalia msg session lock-and-suspend
      fi
    '')
  ];

  systemd.tmpfiles.rules = [
    "L+ /home/${username}/.config/niri/binds-app.kdl - - - - ${./binds-app.kdl}"
    "L+ /home/${username}/.config/niri/binds-noctalia.kdl - - - - ${./binds-noctalia.kdl}"
    "L+ /home/${username}/.config/niri/binds-volume-brightness.kdl - - - - ${./binds-volume-brightness.kdl}"
    "L+ /home/${username}/.config/niri/binds.kdl - - - - ${./binds.kdl}"
    "L+ /home/${username}/.config/niri/config.kdl - - - - ${./config.kdl}"
    "L+ /home/${username}/.config/niri/window-rule.kdl - - - - ${./window-rule.kdl}"
  ];
}
