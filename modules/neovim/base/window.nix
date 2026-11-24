{...}: {
  config.vim.keymaps = [
    {
      mode = "n";
      key = "<Tab>";
      action = "<C-w>w";
      desc = "Switch Window";
    }
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      desc = "Go to Left Window";
      noremap = false;
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      desc = "Go to Lower Window";
      noremap = false;
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      desc = "Go to Upper Window";
      noremap = false;
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      desc = "Go to Right Window";
      noremap = false;
    }
    {
      mode = "n";
      key = "<C-A-k>";
      action = "<cmd>resize +2<cr>";
      desc = "Increase Window Height";
    }
    {
      mode = "n";
      key = "<C-A-j>";
      action = "<cmd>resize -2<cr>";
      desc = "Decrease Window Height";
    }
    {
      mode = "n";
      key = "<C-A-l>";
      action = "<cmd>vertical resize -2<cr>";
      desc = "Decrease Window Width";
    }
    {
      mode = "n";
      key = "<C-A-h>";
      action = "<cmd>vertical resize +2<cr>";
      desc = "Increase Window Width";
    }
  ];
}
