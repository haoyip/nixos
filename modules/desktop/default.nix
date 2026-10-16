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
}
