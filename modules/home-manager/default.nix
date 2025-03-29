{
  inputs,
  system,
  pkgs,
  ...
}: {
  home.stateVersion = "25.05";

  home.username = "hao";
  home.homeDirectory = "/home/hao";

  imports = [
    ./alacritty
    ./btop
    ./direnv
    ./firefox
    ./fish
    ./git
    ./neovim
    ./starship
    ./zellij
  ];

  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default

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
