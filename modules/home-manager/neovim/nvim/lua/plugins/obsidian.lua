return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  lazy = false, -- always load on startup

  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = "Notes",
        path = "~/HY/Notes",
      },
    },
  },

  keys = {
    { "<leader>o<CR>", "<cmd>Obsidian<CR>", { desc = "Obsidian" } },
    { "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Obsidian Open" } },
    { "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Obsidian New" } },
    { "<leader>o/", "<cmd>ObsidianSearch<CR>", { desc = "Obsidian Search" } },
  },
}
