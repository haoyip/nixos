{lua, ...}: {
  config.vim = {
    diagnostics = {
      enable = true;
      config = {
        underline = true;
        update_in_insert = false;
        virtual_text = {
          spacing = 2;
          source = "if_many";
          prefix = "●";
        };
        severity_sort = true;
        float = {
          border = "rounded";
          source = "if_many";
        };
        signs = lua ''
          {
            text = {
              [vim.diagnostic.severity.ERROR] = "",
              [vim.diagnostic.severity.WARN] = "",
              [vim.diagnostic.severity.INFO] = "",
              [vim.diagnostic.severity.HINT] = "󰌵",
            },
          }
        '';
      };
    };

    keymaps = [
      {
        mode = ["n" "v" "i"];
        key = "<A-m>";
        lua = true;
        desc = "Show diagnostics";
        action = ''
          function()
            vim.diagnostic.open_float(nil, { scope = "line" })
          end
        '';
      }
      {
        mode = "n";
        key = "]d";
        lua = true;
        desc = "Next Diagnostic";
        action = "function() vim.diagnostic.jump({ count = vim.v.count1, float = true }) end";
      }
      {
        mode = "n";
        key = "[d";
        lua = true;
        desc = "Prev Diagnostic";
        action = "function() vim.diagnostic.jump({ count = -vim.v.count1, float = true }) end";
      }
      {
        mode = "n";
        key = "]e";
        lua = true;
        desc = "Next Error";
        action = "function() vim.diagnostic.jump({ count = vim.v.count1, severity = vim.diagnostic.severity.ERROR, float = true }) end";
      }
      {
        mode = "n";
        key = "[e";
        lua = true;
        desc = "Prev Error";
        action = "function() vim.diagnostic.jump({ count = -vim.v.count1, severity = vim.diagnostic.severity.ERROR, float = true }) end";
      }
      {
        mode = "n";
        key = "]w";
        lua = true;
        desc = "Next Warning";
        action = "function() vim.diagnostic.jump({ count = vim.v.count1, severity = vim.diagnostic.severity.WARN, float = true }) end";
      }
      {
        mode = "n";
        key = "[w";
        lua = true;
        desc = "Prev Warning";
        action = "function() vim.diagnostic.jump({ count = -vim.v.count1, severity = vim.diagnostic.severity.WARN, float = true }) end";
      }
    ];
  };
}
