{...}: {
  config.vim = {
    opts = {
      fillchars = {
        foldopen = builtins.fromJSON ''"\uf47c"'';
        foldclose = builtins.fromJSON ''"\uf460"'';
        fold = " ";
        foldsep = " ";
        diff = "╱";
        eob = " ";
      };

      foldenable = true;
      foldlevel = 99;
      foldtext = "";
      foldcolumn = "0";
      foldmethod = "indent";
      foldexpr = "v:lua.vim.treesitter.foldexpr()";
    };

    keymaps = [
      {
        mode = "n";
        key = "<A-e>";
        action = "zc";
        desc = "Close fold under cursor";
      }
      {
        mode = "n";
        key = "<A-r>";
        action = "zo";
        desc = "Open fold under cursor";
      }
    ];
  };
}
