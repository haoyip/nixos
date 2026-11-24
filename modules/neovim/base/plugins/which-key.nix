{pkgs, ...}: {
  config.vim.lazy.plugins."which-key.nvim" = {
    package = pkgs.vimPlugins.which-key-nvim;
    setupModule = "which-key";
    setupOpts = {preset = "modern";};
    event = ["DeferredUIEnter"];
    cmd = ["WhichKey"];

    after = ''
      require("which-key").add({
        {
          mode = { "n", "x" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>b", group = "buffer", expand = function() return require("which-key.extras").expand.buf() end, },
          { "<leader>c", group = "code" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>s", group = "search" },
          { "<leader>u", group = "ui" },
          { "<leader>w", group = "windows", proxy = "<C-w>", expand = function() return require("which-key.extras").expand.win() end, },
          { "<leader>x", group = "diagnostics/quickfix" },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
          { "gx", desc = "Open with system app" },
        },
      })
    '';
  };
}
