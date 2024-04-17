local cmp = require("cmp")

return {
  "hrsh7th/nvim-cmp",
  opts = {
    mapping = cmp.mapping.preset.insert({
      ["<A-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<A-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    }),
  },
}
