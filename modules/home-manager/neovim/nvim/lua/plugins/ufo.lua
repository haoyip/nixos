return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },

  config = function()
    require("ufo").setup({

      provider_selector = function(bufnf, filetype, buftype)
        return { "lsp", "indent" }
      end,
    })

    vim.keymap.set("n", "zk", function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()

      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = "Peek Fold" })
  end,
}
