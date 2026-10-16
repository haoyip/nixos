{pkgs, ...}: {
  imports = [
    ./programs.nix
    ./gtk.nix
    ./mime.nix
    ./kitty
    ./btop.nix
    ./bacon
    ./datagrip
    ./yazi
    ./zellij
    ./easyeffects.nix
    ./zen-browser.nix
  ];

  environment.systemPackages = with pkgs; [
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

  systemd.tmpfiles.rules = [
    "L+ /home/hao/.cargo/cargo-generate.toml - - - - ${./cargo-generate.toml}"
  ];
}
