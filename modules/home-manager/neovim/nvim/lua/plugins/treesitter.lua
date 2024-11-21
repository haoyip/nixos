return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- never auto install anything
      ensure_installed = {
        "bash",
        "c",
        "css",
        "fish",
        "git_config",
        "gitcommit",
        "gitignore",
        "html",
        "javascript",
        "json",
        "just",
        "kdl",
        "lua",
        "markdown",
        "nix",
        "php",
        "python",
        "query",
        "rust",
        "rust_with_rstml",
        "sql",
        "ssh_config",
        "terraform",
        "toml",
        "typescript",
        "vim",
        "vimdoc",
        "vue",
        "yaml",
      },
    },
  },
  {
    "rayliwell/tree-sitter-rstml",
    dependencies = { "nvim-treesitter" },
    build = ":TSUpdate",
    config = function()
      require("tree-sitter-rstml").setup()
    end,
  },
  -- Experimental automatic tag closing and renaming (optional)
  {
    "rayliwell/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}
