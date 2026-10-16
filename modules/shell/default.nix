{pkgs, ...}: {
  imports = [
    ./btop.nix
    ./bacon
    ./yazi
    ./zellij
  ];

  environment.systemPackages = with pkgs; [
    # cli
    bat
    caligula
    delta
    dua
    eza
    fastfetch
    fd
    ffmpeg
    fishPlugins.fzf-fish
    fswatch
    fzf
    gpclient
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

    # nix
    nh
    nix-output-monitor

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
    opencode
    opentofu
  ];

  programs = {
    fish = {
      enable = true;

      interactiveShellInit = builtins.readFile ./fish/config.fish;
    };

    starship = {
      enable = true;
      settings.add_newline = false;
    };

    zoxide = {
      enable = true;
    };

    direnv.enable = true;

    git = {
      enable = true;

      config = {
        user = {
          email = "haoyiphoh@protonmail.com";
          name = "haoyiphoh";
        };

        init.defaultBranch = "main";

        core.pager = "delta";
        interactive.diffFilter = "delta --color-only";

        delta = {
          navigate = true;
          light = false;
          side-by-side = false;
        };

        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";

        gpg.format = "ssh";
      };
    };

    lazygit = {
      enable = true;

      settings.git.diffRenderers = [
        {
          colorArg = "always";
          command = "delta --dark --paging=never";
        }
      ];
    };
  };

  systemd.tmpfiles.rules = [
    "L+ /home/hao/.config/bat/config - - - - ${pkgs.writeText "bat-config" "--theme=catppuccin-frappe"}"
    "L+ /home/hao/.config/bat/themes - - - - ${./bat/themes}"

    "L+ /home/hao/.cargo/cargo-generate.toml - - - - ${./cargo-generate.toml}"
  ];
}
