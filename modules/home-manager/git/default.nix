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

  programs.lazygit.enable = true;

  xdg = {
    enable = true;
    configFile."git/config".source = ./.gitconfig;
    configFile."lazygit/config.yml".source = ./lazygit.yml;
  };
}
