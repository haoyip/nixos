{pkgs, ...}: {
  home.stateVersion = "25.11";

  home.username = "hao";
  home.homeDirectory = "/home/hao";

  imports = [
    ./alacritty
    ./bacon
    ./btop
    ./datagrip
    ./direnv
    ./fish
    ./git
    ./neovim
    ./starship
    ./zellij
    ./zen
  ];

  home.packages = with pkgs; [
    # cli
    bat
    caligula
    dua
    eza
    fastfetch
    fd
    ffmpeg
    fswatch
    fzf
    gptfdisk
    jaq
    lsof
    nmap
    pastel
    pciutils
    pgcli
    psmisc
    ripgrep
    rsync
    smartmontools
    speedtest-cli
    tealdeer
    usbutils
    wakeonlan
    wl-clipboard
    xh
    yt-dlp
    zoxide

    # nix
    nh
    nix-output-monitor
    nvd

    # desktop apps
    anki
    anydesk
    easyeffects
    jellyfin-mpv-shim
    krita
    mpv
    obsidian
    onlyoffice-desktopeditors
    qbittorrent
    ungoogled-chromium
    vlc
    wireshark

    # dev
    bunyan-rs
    cargo-deny
    cargo-expand
    cargo-generate
    cargo-machete
    cargo-nextest
    cargo-outdated
    cargo-wizard
    distrobox
    doctl
    flyctl
    just
    mago
    opentofu
    phpactor
    tree-sitter

    # linter, formatter
    alejandra
    blade-formatter
    leptosfmt
    rustywind
    shfmt
    stylua
    xmlformat
  ];

  home.file.".cargo/cargo-generate.toml".source = ./cargo-generate.toml;
}
