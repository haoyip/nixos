{pkgs, ...}: {
  home.stateVersion = "25.05";

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
    eza
    fastfetch
    fd
    fswatch
    fzf
    jaq
    lsof
    nmap
    psmisc
    pgcli
    ripgrep
    tealdeer
    wl-clipboard
    xh
    zoxide
    ffmpeg
    yt-dlp
    wakeonlan
    gptfdisk
    smartmontools
    pastel
    caligula
    speedtest-cli
    rsync

    # nix
    nh
    nix-output-monitor
    nvd

    # desktop apps
    anki
    anydesk
    easyeffects
    krita
    mpv
    jellyfin-mpv-shim
    onlyoffice-bin
    qbittorrent
    todoist-electron
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
    opentofu
    php84Packages.php-codesniffer
    php84Packages.php-cs-fixer
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
