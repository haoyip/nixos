{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.noctalia.nixosModules.default
  ];

  services.noctalia-shell.enable = true;

  environment.defaultPackages = with pkgs; [
    bibata-cursors
    brightnessctl
    hyprpicker
    niri
    xdg-utils
    xwayland-satellite
  ];

  services.greetd = {
    enable = true;

    settings = {
      initial_session = {
        command = "niri-session";
        user = "hao";
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
  };

  environment.systemPackages = [
    # Spawn foot in the current working directory of the focused terminal's shell,
    # falling back to the default directory if no shell process is detected.
    (pkgs.writeShellScriptBin "foot-smart" ''
      # Get focused window PID
      termpid=$(niri msg focused-window | rg '^  PID:' | awk '{print $2}')

      # Try to find shell child
      shellpid=$(pgrep -P "$termpid" | head -n1)

      if [ -n "$shellpid" ] && [ -e "/proc/$shellpid/cwd" ]; then
          dir=$(readlink "/proc/$shellpid/cwd")
          exec foot -D "$dir"
      else
          exec foot
      fi
    '')

    # Spawn neovide in the current working directory of the focused terminal's shell,
    # falling back to the default directory if no shell process is detected.
    (pkgs.writeShellScriptBin "neovide-smart" ''
      # Get focused window PID
      termpid=$(niri msg focused-window | rg '^  PID:' | awk '{print $2}')

      # Try to find shell child
      shellpid=$(pgrep -P "$termpid" | head -n1)

      if [ -n "$shellpid" ] && [ -e "/proc/$shellpid/cwd" ]; then
          dir=$(readlink "/proc/$shellpid/cwd")

          # Use direnv exec if .envrc exists
          if [ -f "$dir/.envrc" ]; then
              cd "$dir" && exec direnv exec . neovide
          else
              cd "$dir" && exec neovide
          fi
      else
          # fallback if directory can't be determined
          exec neovide
      fi
    '')
  ];
}
