{...}: {
  config.vim = {
    navigation.harpoon = {
      enable = true;
      setupOpts.settings.save_on_toggle = true;

      mappings = {
        markFile = "<leader>a";
        listMarks = "<leader>h";
        file1 = "<leader>1";
        file2 = "<leader>2";
        file3 = "<leader>3";
        file4 = "<leader>4";
      };
    };
  };

  config.vim.keymaps = [
    {
      mode = "n";
      key = "<leader>p";
      lua = true;
      desc = "Harpoon: Previous";
      action = ''function() require("harpoon"):list():prev() end'';
    }
    {
      mode = "n";
      key = "<leader>n";
      lua = true;
      desc = "Harpoon: Next";
      action = ''function() require("harpoon"):list():next() end'';
    }
  ];
}
