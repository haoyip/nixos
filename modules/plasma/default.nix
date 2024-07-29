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
    # desktop theming
    bibata-cursors
    catppuccin-gtk
    catppuccin-kde
    catppuccin-sddm
    tela-circle-icon-theme

    # firmware & driver tools
    aha
    clinfo
    glxinfo
    pciutils
    vulkan-tools
    wayland-utils
    xdg-utils
  ];

  i18n.inputMethod.fcitx5 = {
    plasma6Support = true;
    waylandFrontend = true;
  };

  programs.kdeconnect.enable = true;
}
