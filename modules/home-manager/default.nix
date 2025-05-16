{pkgs, ...}: {
  home.stateVersion = "25.05";

  home.username = "hao";
  home.homeDirectory = "/home/hao";

  imports = [
    ./alacritty
    ./btop
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

    # nix
    nh
    nix-output-monitor
    nvd

    # desktop apps
    easyeffects
    mpv
    wireshark
    vlc

    # dev
    bacon
    bunyan-rs
    cargo-deny
    cargo-expand
    cargo-generate
    cargo-machete
    cargo-nextest
    cargo-outdated
    cargo-watch
    cargo-wizard
    distrobox
    flyctl
    just
    php84Packages.php-codesniffer

    # php84 is mark as broken
    php83Packages.php-cs-fixer

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
