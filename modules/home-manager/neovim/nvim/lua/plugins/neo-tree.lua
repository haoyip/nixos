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
        -- general
        ".git",
        ".gitignore",
        ".dockerignore",
        ".tmp",
        "dist",
        ".editorconfig",

        -- nix
        "flake.lock",
        "result",

        -- direnv
        ".direnv",
        ".envrc",

        -- javascript
        "node_modules",
        ".nuxt",
        ".output",
        "bun.lockb",
        ".prettierrc",
        ".prettierignore",
        ".eslintrc.cjs",

        -- rust
        ".cargo",
        "Cargo.lock",
        "target",
        ".sqlx",
        "rust-toolchain.toml",
        "rustfmt.toml",

        -- terraform
        ".terraform",
        ".terraform.lock.hcl",
        "terraform.tfstate",
        "terraform.tfstate.backup",

        -- misc.
        ".strapi",
        ".strapi-updater.json",
      },
    }

    opts.window = {
      position = "right",
      width = "46",
    }

    return opts
  end,
}
