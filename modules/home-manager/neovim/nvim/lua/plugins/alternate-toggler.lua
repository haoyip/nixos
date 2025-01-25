return {
  "rmagatti/alternate-toggler",
  event = { "BufReadPost" },

  config = function()
    require("alternate-toggler").setup({
      alternates = {
        ["==="] = "!==",
        ["=="] = "!=",
      },
    })

    vim.keymap.set("n", "<leader>j", "<cmd>lua require('alternate-toggler').toggleAlternate()<CR>")
  end,
}
