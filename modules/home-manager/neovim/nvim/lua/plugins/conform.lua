return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      blade = { "blade-formatter", "rustywind" },
      html = { "prettier", "rustywind" },
      nix = { "alejandra" },
      rust = { "rustywind", "leptosfmt", "rustfmt" },
      vue = { "prettier", "rustywind" },
      xml = { "xmlformat" },
    },
  },
}
