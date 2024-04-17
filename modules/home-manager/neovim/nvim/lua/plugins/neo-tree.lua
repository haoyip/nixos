return {
  "nvim-neo-tree/neo-tree.nvim",

  keys = {
    { "<A-1>", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
    { "<C-A-1>", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
  },

  opts = function(_, opts)
    opts.filesystem.filtered_items = {
      -- show git ignored files
      hide_gitignored = false,
      hide_dotfiles = false,

      hide_by_name = {
        -- General
        ".git",
        ".gitignore",
        ".dockerignore",
        ".tmp",
        "dist",
        ".editorconfig",

        -- Javascript
        "node_modules",
        ".nuxt",
        ".output",
        "bun.lockb",
        ".prettierrc",
        ".prettierignore",
        ".eslintrc.cjs",

        -- Rust
        "Cargo.lock",
        "target",
        ".sqlx",

        -- Terraform
        ".terraform",
        ".terraform.lock.hcl",
        "terraform.tfstate",
        "terraform.tfstate.backup",

        -- Misc.
        ".strapi",
        ".strapi-updater.json",
      },
    }

    opts.window = {
      position = "right",
      width = "36",
    }

    return opts
  end,
}
