{
  programs.git = {
    enable = true;

    signing = {
      format = "ssh";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
      };
    };
  };

  xdg = {
    enable = true;
    configFile."git/config".source = ./.gitconfig;
  };
}
