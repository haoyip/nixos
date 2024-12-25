return {
  "ibhagwan/fzf-lua",

  opts = function(_, opts)
    local config = require("fzf-lua.config")

    config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
    config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
    config.defaults.keymap.fzf["ctrl-x"] = "jump"
    config.defaults.keymap.fzf["ctrl-e"] = "preview-page-down"
    config.defaults.keymap.fzf["ctrl-y"] = "preview-page-up"
    config.defaults.keymap.builtin["<c-e>"] = "preview-page-down"
    config.defaults.keymap.builtin["<c-y>"] = "preview-page-up"

    opts.winopts = {
      on_create = function()
        -- for paste in neovide
        vim.keymap.set("t", "<C-S-V>", [['<C-\><C-N>"'.nr2char(getchar()).'pi']], { expr = true, buffer = true })
      end,
    }

    opts.oldfiles = {
      -- include recently viewed files
      include_current_session = true,
    }

    require("fzf-lua").setup(opts)
  end,

  keys = {
    { "<leader>k", "<cmd>FzfLua git_files<cr>", desc = "Find Files (git-files)" },
    { "<leader>r", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent (cwd)" },
    { "<leader>'", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
    { "<leader>m", "<cmd>FzfLua resume<cr>", desc = "Resume" },
    { "<leader>v", LazyVim.pick("grep_visual"), mode = "v", desc = "Selection (Root Dir)" },
  },
}
