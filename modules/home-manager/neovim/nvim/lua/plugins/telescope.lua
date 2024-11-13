return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "Myzel394/jsonfly.nvim",
  },

  keys = {
    {
      "<leader>j",
      "<cmd>Telescope jsonfly<cr>",
      desc = "Open json(fly)",
      ft = { "json" },
      mode = "n",
    },
    {
      "<leader>n",
      "<cmd>Telescope find_files<cr>",
      desc = "Find Files (Root Dir)",
      mode = "n",
    },
  },

  opts = {
    defaults = {
      mappings = {
        i = {
          ["<A-j>"] = require("telescope.actions").move_selection_next,
          ["<A-k>"] = require("telescope.actions").move_selection_previous,
        },
        n = {
          ["<A-j>"] = require("telescope.actions").move_selection_next,
          ["<A-k>"] = require("telescope.actions").move_selection_previous,
        },
      },
    },
  },
}
