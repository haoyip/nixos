{pkgs, ...}: {
  home.stateVersion = "25.11";

  home.username = "hao";
  home.homeDirectory = "/home/hao";

  imports = [
    ./bacon
    ./bat
    ./btop.nix
    ./datagrip
    ./direnv.nix
    ./fish
    ./kitty
    ./git
    ./mime.nix
    ./starship
    ./yazi
    ./zellij
    ./zen-browser.nix
  ];

  home.packages = with pkgs; [
    # cli
    caligula
    dua
    eza
    fastfetch
    fd
    ffmpeg
    fswatch
    fzf
    gptfdisk
    inotify-tools
    jaq
    lsof
    nmap
    pastel
    pciutils
    pgcli
    psmisc
    radeontop
    ripgrep
    rsync
    smartmontools
    speedtest-cli
    sshfs
    tealdeer
    unzip
    usbutils
    wakeonlan
    wl-clipboard
    xh
    yt-dlp
    zip
    zoxide
    gpclient

    # nix
    nh
    nix-output-monitor

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

    # dev
    bunyan-rs
    cargo-deny
    cargo-expand
    cargo-generate
    cargo-machete
    cargo-nextest
    cargo-outdated
    cargo-wizard
    just
    opentofu
    opencode
  ];

  home.file.".cargo/cargo-generate.toml".source = ./cargo-generate.toml;

  services.easyeffects.enable = true;

  gtk = {
    enable = true;
    gtk4.theme = null;

    iconTheme = {
      name = "Tela";
      package = pkgs.tela-icon-theme;
    };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      size = 32;
    };
  };
}
