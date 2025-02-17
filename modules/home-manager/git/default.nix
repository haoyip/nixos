{
  programs.git = {
    enable = true;
    delta.enable = true;

    signing = {
      format = "ssh";
    };
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
