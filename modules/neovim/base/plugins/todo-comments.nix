{...}: {
  config.vim = {
    notes.todo-comments = {
      enable = true;
      setupOpts = {};
      mappings = {
        quickFix = null;
        telescope = null;
        trouble = "<leader>xt";
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "]t";
        lua = true;
        desc = "Next Todo Comment";
        action = ''function() require("todo-comments").jump_next() end'';
      }
      {
        mode = "n";
        key = "[t";
        lua = true;
        desc = "Previous Todo Comment";
        action = ''function() require("todo-comments").jump_prev() end'';
      }
    ];
  };
}
