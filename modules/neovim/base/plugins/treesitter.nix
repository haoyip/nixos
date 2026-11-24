{pkgs, ...}: {
  config.vim = {
    treesitter = {
      enable = true;
      highlight.enable = true;
      indent.enable = true;
      fold = true;

      # https://neovim.io/doc/user/treesitter/
      addDefaultGrammars = true;

      grammars = with pkgs.vimPlugins.nvim-treesitter.grammarPlugins; [
        bash
        blade
        dockerfile
        fish
        git_config
        gitcommit
        gitignore
        just
        kdl
        sql
        ssh_config
      ];

      textobjects = {
        enable = true;
        setupOpts.move = {
          enable = true;
          set_jumps = true;
          keys = {
            goto_next_start = {
              "]f" = "@function.outer";
              "]c" = "@class.outer";
              "]a" = "@parameter.inner";
            };
            goto_next_end = {
              "]F" = "@function.outer";
              "]C" = "@class.outer";
              "]A" = "@parameter.inner";
            };
            goto_previous_start = {
              "[f" = "@function.outer";
              "[c" = "@class.outer";
              "[a" = "@parameter.inner";
            };
            goto_previous_end = {
              "[F" = "@function.outer";
              "[C" = "@class.outer";
              "[A" = "@parameter.inner";
            };
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>uT";
        lua = true;
        desc = "Treesitter";
        action = "function() Snacks.toggle.treesitter():toggle() end";
      }

      # treesitter node incremental selections
      {
        mode = ["n" "x" "o"];
        key = "<A-o>";
        lua = true;
        desc = "Select parent treesitter node or outer incremental lsp selections";
        action = ''
          function()
            if vim.treesitter.get_parser(nil, nil, { error = false }) then
              require("vim.treesitter._select").select_parent(vim.v.count1)
            else
              vim.lsp.buf.selection_range(vim.v.count1)
            end
          end
        '';
      }
      {
        mode = ["n" "x" "o"];
        key = "<A-i>";
        lua = true;
        desc = "Select child treesitter node or inner incremental lsp selections";
        action = ''
          function()
            if vim.treesitter.get_parser(nil, nil, { error = false }) then
              require("vim.treesitter._select").select_child(vim.v.count1)
            else
              vim.lsp.buf.selection_range(-vim.v.count1)
            end
          end
        '';
      }
    ];

    lazy.plugins."ts-comments.nvim" = {
      package = pkgs.vimPlugins.ts-comments-nvim;
      setupModule = "ts-comments";
      event = ["DeferredUIEnter"];
    };
  };
}
