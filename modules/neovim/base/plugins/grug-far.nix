{...}: {
  config.vim = {
    utility.grug-far-nvim = {
      enable = true;
      setupOpts.headerMaxWidth = 80;
    };
  };

  config.vim.keymaps = [
    {
      mode = ["n" "x"];
      key = "<leader>sr";
      lua = true;
      desc = "GrugFar";
      action = ''
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = { filesFilter = ext and ext ~= "" and "*." .. ext or nil },
          })
        end
      '';
    }
    {
      mode = "x";
      key = "<leader>si";
      lua = true;
      desc = "GrugFarWithin";
      action = ''function() require("grug-far").open({ visualSelectionUsage = "operate-within-range" }) end'';
    }
  ];
}
