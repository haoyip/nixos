{pkgs, ...}: {
  home.packages = with pkgs; [
    zellij
  ];

  xdg = {
    enable = true;

    configFile."zellij/config.kdl".source = ./config.kdl;
    configFile."zellij/themes/".source = ./themes;
  };
}
