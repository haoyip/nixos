return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,

  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    "BufReadPre /data/8tb_1/HY/Library/Notes/*",
    "BufNewFile /data/8tb_1/HY/Library/Notes/*",
  },

  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },

  opts = {
    workspaces = {
      {
        name = "personal",
        path = "/data/8tb_1/HY/Library/Notes/",
      },
    },

    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
    },
  },

  keys = {
    { "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>", desc = "Obsidian Quick Switch", remap = true },
    { "<leader>ox", "<cmd>ObsidianOpen<cr>", desc = "Obsidian Open", remap = true },
    { "<leader>ot", "<cmd>ObsidianTags<cr>", desc = "Obsidian Tags", remap = true },
    { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "Obsidian New", remap = true },
    { "<leader>ol", "<cmd>ObsidianLink<cr>", desc = "Obsidian Link", remap = true },
    { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Obsidian Back Links", remap = true },
    { "<leader>o/", "<cmd>ObsidianSearch<cr>", desc = "Obsidian Search", remap = true },
  },
}
