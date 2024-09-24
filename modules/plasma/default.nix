{pkgs, ...}: {
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;

    theme = "catppuccin-mocha";
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

    # desktop theming
    bibata-cursors
    catppuccin-gtk
    catppuccin-kde
    catppuccin-sddm

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
          fcitx5-mozc
          fcitx5-nord
        ];
      };
    };
  };

  programs.kdeconnect.enable = true;
}
