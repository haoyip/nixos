{pkgs, ...}: {
  imports = [
    ./datagrip
    ./easyeffects.nix
    ./game.nix
    ./gtk.nix
    ./kitty
    ./mime.nix
    ./niri
    ./zen-browser.nix
  ];

  environment.systemPackages = with pkgs; [
    # desktop apps
    anki
    anydesk
    godot
    imv
    jellyfin-mpv-shim
    krita
    libreoffice
    mpv
    neovide
    obs-studio
    qbittorrent
    remmina
    ungoogled-chromium
    vlc
    wireshark
  ];

  programs.kdeconnect.enable = true;

  fonts = {
    fontconfig = {
      enable = true;
      subpixel.rgba = "rgb";
      hinting.style = "slight";
    };

    packages = with pkgs; [
      liberation_ttf
      maple-mono.NF
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      waylandFrontend = true;

      addons = with pkgs; [
        qt6Packages.fcitx5-chinese-addons
        qt6Packages.fcitx5-configtool
      ];
    };
  };
}
