{pkgs, ...}: {
  home.packages = with pkgs; [
    jetbrains.datagrip
  ];

  xdg = {
    enable = true;

    configFile."ideavim/ideavimrc".source = ./ideavimrc;
  };
}
