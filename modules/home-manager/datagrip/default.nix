{pkgs, ...}: {
  home.packages = with pkgs; [
    jetbrains.datagrip
  ];

  xdg = {
    enable = true;

    configFile."ideavim/ideavimrc".source = ./ideavimrc;
    configFile."JetBrains/DataGrip2025.3/datagrip64.vmoptions".source = ./datagrip64.vmoptions;
  };
}
