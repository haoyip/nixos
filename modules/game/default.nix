{pkgs, ...}: {
  programs.steam.enable = true;
  programs.gamemode.enable = true;

  environment.defaultPackages = with pkgs; [
    mangohud
    mangojuice

    (retroarch.withCores (cores:
      with cores; [
        libretro.swanstation
        libretro.pcsx2
      ]))
  ];
}
