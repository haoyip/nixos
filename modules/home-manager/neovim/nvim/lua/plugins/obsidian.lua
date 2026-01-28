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
    legacy_commands = false,
  },

  keys = {
    { "<leader>o<CR>", "<cmd>Obsidian<CR>", { desc = "Obsidian" } },
    { "<leader>oo", "<cmd>Obsidian open<CR>", { desc = "Obsidian Open" } },
    { "<leader>on", "<cmd>Obsidian new<CR>", { desc = "Obsidian New" } },
    { "<leader>o/", "<cmd>Obsidian search<CR>", { desc = "Obsidian Search" } },
  },
}
