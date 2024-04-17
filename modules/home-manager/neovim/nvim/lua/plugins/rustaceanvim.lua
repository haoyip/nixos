return {
  "mrcjkb/rustaceanvim",
  opts = {
    server = {
      default_settings = {
        -- rust-analyzer language server configuration
        ["rust-analyzer"] = {
          rustfmt = {
            overrideCommand = {
              "leptosfmt",
              "--stdin",
              "--rustfmt",
              "--config-file",
              "/home/hao/.config/nvim/leptosfmt.toml",
            },
          },
        },
      },
    },
  },
}
