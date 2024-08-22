{pkgs, ...}: {
  home.stateVersion = "24.05";

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

    # nix
    nh
    nix-output-monitor
    nvd

    # desktop apps
    easyeffects
    mpv
    wireshark

    # dev
    bacon
    bunyan-rs
    cargo-expand
    cargo-machete
    cargo-outdated
    cargo-watch
    cargo-wizard
    just
    flyctl

    # linter, formatter
    alejandra
    leptosfmt
    rustywind
    shfmt
    stylua
  ];
}
