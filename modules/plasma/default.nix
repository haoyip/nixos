{pkgs, ...}: {
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
    okular
    kate
    elisa
    khelpcenter
    print-manager
  ];

  environment.systemPackages = with pkgs; [
    kdePackages.kcolorchooser
    kdePackages.keysmith
    kdePackages.filelight
    kcalc

    # desktop theming
    bibata-cursors
    catppuccin-gtk
    catppuccin-kde

    # firmware & driver tools
    aha
    clinfo
    glxinfo
    pciutils
    vulkan-tools
    wayland-utils
    xdg-utils
  ];

  i18n = {
    defaultLocale = "en_US.UTF-8";

    inputMethod = {
      enable = true;
      type = "fcitx5";

      fcitx5 = {
        plasma6Support = true;
        waylandFrontend = true;

        addons = with pkgs; [
          fcitx5-chinese-addons
          fcitx5-configtool
        ];
      };
    };
  };

  programs.kdeconnect.enable = true;
}
