{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bat
    delta
    fishPlugins.fzf-fish
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
      enableFishIntegration = true;
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
  ];
}
