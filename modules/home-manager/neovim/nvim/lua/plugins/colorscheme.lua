return {
  { "folke/tokyonight.nvim", enabled = false },

  {
    "sainnhe/sonokai",
    event = "VeryLazy",
    config = function()
      vim.g.sonokai_better_performance = 1
    end,
    enabled = false,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-frappe",
    },
  },
}
