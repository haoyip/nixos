return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            hint = { enable = true },
          },
        },
      },

      tailwindcss = {
        -- exclude a filetype from the default_config
        -- filetypes_exclude = { "markdown" },
        -- add additional filetypes to the default_config
        filetypes_include = { "rust" },
        -- to fully override the default_config, change the below
        -- filetypes = {}

        init_options = {
          userLanguages = {
            rust = "html",
          },
        },
      },

      nixd = {},

      volar = {
        init_options = {
          vue = {
            hybridMode = true,
          },
        },
      },
    },
  },
}
