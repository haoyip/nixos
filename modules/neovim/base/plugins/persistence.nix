{pkgs, ...}: {
  config.vim.lazy.plugins."persistence.nvim" = {
    package = pkgs.vimPlugins.persistence-nvim;
    setupModule = "persistence";

    keys = [
      {
        mode = "n";
        key = "<leader>qs";
        lua = true;
        desc = "Restore Session";
        action = ''function() require("persistence").load() end'';
      }
      {
        mode = "n";
        key = "<leader>qS";
        lua = true;
        desc = "Select Session";
        action = ''function() require("persistence").select() end'';
      }
      {
        mode = "n";
        key = "<leader>ql";
        lua = true;
        desc = "Restore Last Session";
        action = ''function() require("persistence").load({ last = true }) end'';
      }
      {
        mode = "n";
        key = "<leader>qd";
        lua = true;
        desc = "Don't Save Current Session";
        action = ''function() require("persistence").stop() end'';
      }
    ];
  };
}
