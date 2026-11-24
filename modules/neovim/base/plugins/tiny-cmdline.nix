{
  pkgs,
  lib,
  ...
}: {
  config.vim = {
    opts = {
      cmdheight = 0;
    };

    # ui2 enable at startup, enable tiny-cmdline after
    luaConfigRC.ui2 = lib.nvim.dag.entryAnywhere ''
      require("vim._core.ui2").enable({})
    '';

    lazy.plugins."tiny-cmdline.nvim" = {
      package = pkgs.vimPlugins.tiny-cmdline-nvim;
      setupModule = "tiny-cmdline";
      event = ["DeferredUIEnter"];
    };
  };
}
