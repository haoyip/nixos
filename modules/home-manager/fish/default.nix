{pkgs, ...}: {
  home.packages = with pkgs; [
    fishPlugins.fzf-fish
  ];

  xdg = {
    enable = true;

    configFile."fish/config.fish".source = ./config.fish;
  };
}
