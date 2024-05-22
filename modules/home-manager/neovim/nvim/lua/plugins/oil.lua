return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      columns = { "icon" },
      view_options = {
        show_hidden = true,
      },
    })

    -- Open parent directory in current window
    vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })

    -- Open parent directory in floating window
    vim.keymap.set("n", "<C-1>", require("oil").toggle_float)
  end,
}
