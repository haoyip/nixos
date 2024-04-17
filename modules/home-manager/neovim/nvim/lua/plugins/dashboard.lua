return {
  "nvimdev/dashboard-nvim",
  opts = {
    config = {
      header = vim.split(string.rep("\n", 6), "\n"),
    },
  },
}
