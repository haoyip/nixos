return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- never auto install anything
      ensure_installed = {
        "bash",
        "blade",
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
        "php_only",
        "phpdoc",
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
  -- Blade
  {
    "nvim-treesitter/nvim-treesitter",
    config = function(_, opts)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }

      vim.filetype.add({
        pattern = {
          [".*%.blade%.php"] = "blade",
        },
      })

      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
