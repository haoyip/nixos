{ pkgs, ... }:

{
  home.stateVersion = "23.11";

  home.username = "hao";
  home.homeDirectory = "/home/hao";

  imports = [
    ./alacritty
    ./btop
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
    fd
    fswatch
    fzf
    jaq
    neofetch
    ripgrep
    tealdeer
    wl-clipboard
    zoxide

    # desktop apps
    mpv

    # dev
    bacon
    bunyan-rs
    cargo-expand
    cargo-machete
    cargo-outdated
    cargo-watch
    cargo-wizard

    # linter, formatter
    leptosfmt
    nixpkgs-fmt
    shfmt
    stylua
  ];
}

