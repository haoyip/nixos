return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      rust = { "rustywind", "leptosfmt", "rustfmt" },
      html = { "prettier", "rustywind" },
      vue = { "prettier", "rustywind" },
      nix = { "alejandra" },
    },
  },
}
