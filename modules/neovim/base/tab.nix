{...}: {
  config.vim.keymaps = [
    {
      mode = "n";
      key = "<A-T>";
      action = "<cmd>tabnew %<cr>";
      desc = "New tab";
    }
    {
      mode = "n";
      key = "<A-D>";
      action = "<cmd>tabclose<cr>";
      desc = "Close tab";
    }
    {
      mode = "n";
      key = "<A-L>";
      action = "<cmd>tabnext<cr>";
      desc = "Next tab";
    }
    {
      mode = "n";
      key = "<A-H>";
      action = "<cmd>tabprevious<cr>";
      desc = "Previous tab";
    }
    {
      mode = "n";
      key = "<A-O>";
      action = "<cmd>tabonly<cr>";
      desc = "Close all other tabs";
    }
  ];
}
