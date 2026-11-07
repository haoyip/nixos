{pkgs, ...}: {
  imports = [
    ./floorp.nix
    ./game.nix
    ./ghostty
    ./niri
  ];

  fonts = {
    fontconfig = {
      enable = true;
      subpixel.rgba = "rgb";
      hinting.style = "slight";
    };

    packages = with pkgs; [
      liberation_ttf
      maple-mono.NF
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];
  };
}
