return {
  "rmagatti/alternate-toggler",
  event = { "BufReadPost" },

  config = function()
    require("alternate-toggler").setup({
      alternates = {
        ["/"] = "\\",
        ["\\"] = "/",

        ["on"] = "off",
        ["off"] = "on",

        ["yes"] = "no",
        ["no"] = "yes",
      },
    })

    vim.keymap.set("n", "<leader>j", "<cmd>lua require('alternate-toggler').toggleAlternate()<CR>")
  end,
}
