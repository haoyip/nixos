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

    # desktop tools
    aha
    clinfo
    ddcutil
    glxinfo
    pciutils
    vulkan-tools
    wayland-utils
    xdg-utils

    # desktop theming
    bibata-cursors
    catppuccin-kde
    catppuccin-gtk
    tela-circle-icon-theme

    # desktop apps
    mpv

    # dev
    bacon
    bun
    bunyan-rs
    cargo-expand
    cargo-leptos
    cargo-machete
    cargo-outdated
    cargo-watch
    cargo-wizard
    just
    nodejs
    tailwindcss
    trunk

    # linter, formatter
    leptosfmt
    nixpkgs-fmt
    shfmt
    stylua
  ];
}

