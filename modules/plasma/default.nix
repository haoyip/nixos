{pkgs, ...}: {
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

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
    catppuccin-kde
    catppuccin-gtk
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
}
