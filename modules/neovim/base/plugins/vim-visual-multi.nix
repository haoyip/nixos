{pkgs, ...}: {
  config.vim = {
    lazy.plugins."vim-visual-multi" = {
      package = pkgs.vimPlugins.vim-visual-multi;
      event = ["DeferredUIEnter"];
    };

    keymaps = [
      {
        mode = "n";
        key = "<A-j>";
        action = "<C-down>";
        noremap = false;
      }
      {
        mode = "n";
        key = "<A-k>";
        action = "<C-up>";
        noremap = false;
      }
    ];
  };
}
