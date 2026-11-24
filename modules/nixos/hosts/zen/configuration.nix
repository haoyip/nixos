{
  neovim,
  pkgs,
  ...
}: {
  networking.hostName = "zen";

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    package = (neovim.full).overrideAttrs (old: {
      meta = pkgs.neovim-unwrapped.meta // (old.meta or {});
    });
  };
}
