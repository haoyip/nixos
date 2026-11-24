{pkgs, ...}: {
  config.vim.extraPlugins = {
    catppuccin-nvim = {
      package = pkgs.vimPlugins.catppuccin-nvim;

      setup = ''
        require("catppuccin").setup({
          transparent_background = false,

          float = {
            transparent = false,
            solid = false,
          },

          show_end_of_buffer = true,

          lsp_styles = {
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },

          integrations = {
            blink_cmp = true,
            flash = true,
            gitsigns = true,
            grug_far = true,
            lsp_trouble = true,
            mini = true,
            snacks = true,
            treesitter_context = true,
            which_key = true,
            yazi = true,
          },
        })

        vim.cmd.colorscheme("catppuccin-frappe")
      '';
    };
  };
}
