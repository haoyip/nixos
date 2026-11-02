{
  inputs,
  pkgs,
  ...
}: {
  networking.hostName = "zen";

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    package = inputs.neovim.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
}
