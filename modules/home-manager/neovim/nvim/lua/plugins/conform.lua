return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      blade = { "blade-formatter", "rustywind" },
      nix = { "alejandra" },
      rust = { "rustywind", "leptosfmt", "rustfmt", "dioxus" },
      xml = { "xmlformat" },
      php = { "pint" },
      vue = { "oxfmt" },
      json = { "oxfmt" },
      jsonc = { "oxfmt" },
      typescript = { "oxfmt" },
      javascript = { "oxfmt" },
    },
  },
}
