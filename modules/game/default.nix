{pkgs, ...}: {
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  environment.defaultPackages = with pkgs; [
    mangohud
    mangojuice
    libretro.swanstation
  ];
}
