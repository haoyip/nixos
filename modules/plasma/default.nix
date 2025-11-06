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
    kdePackages.kcalc
    kdePackages.francis

    # desktop theming
    bibata-cursors
    catppuccin-gtk
    catppuccin-kde

    # firmware & driver tools
    aha
    clinfo
    mesa-demos
    pciutils
    vulkan-tools
    wayland-utils
    xdg-utils
  ];

  programs.kdeconnect.enable = true;
}
