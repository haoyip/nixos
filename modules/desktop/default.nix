{pkgs, ...}: {
  imports = [
    ./niri
    ./kitty
    ./gtk.nix
    ./mime.nix
    ./easyeffects.nix
    ./zen-browser.nix
    ./datagrip
  ];

  environment.systemPackages = with pkgs; [
    # desktop apps
    anki
    imv
    jellyfin-mpv-shim
    krita
    mpv
    obs-studio
    libreoffice
    qbittorrent
    ungoogled-chromium
    vlc
    wireshark
    remmina
    neovide
    godot
    anydesk
  ];
}
