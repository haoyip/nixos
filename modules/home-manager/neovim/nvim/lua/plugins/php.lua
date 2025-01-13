return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      -- phpactor = {},
    },
    setup = {
      -- phpactor = function(_, opts)
      --   local lspconfig = require("lspconfig")
      --   local configs = require("lspconfig.configs")
      --   local util = require("lspconfig.util")
      --
      --   if not configs.phpactor then
      --     configs.phpactor = {
      --       default_config = {
      --         cmd = { "phpactor", "language-server" },
      --         filetypes = { "php" },
      --         root_dir = function(pattern)
      --           local cwd = vim.loop.cwd()
      --           local root = util.root_pattern("composer.json", ".git")(pattern)
      --
      --           -- prefer cwd if root is a descendant
      --           return util.path.is_descendant(cwd, root) and cwd or root
      --         end,
      --         init_options = {
      --           ["language_server_completion.trim_leading_dollar"] = true,
      --         },
      --       },
      --     }
      --   end
      --
      --   lspconfig.phpactor.setup(opts)
      -- end,
    },
  },
}
