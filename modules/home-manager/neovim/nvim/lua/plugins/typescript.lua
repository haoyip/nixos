return {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {
    filetypes = {
      "javascript",
      "typescript",
      "vue",
    },
    settings = {
      tsserver_plugins = {
        "@vue/language-server",
        "@vue/typescript-plugin",
      },
    },
  },
}
