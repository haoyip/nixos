return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "enter",
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-h>"] = { "hide", "fallback" },
      ["<C-l>"] = { "accept", "fallback" },
      ["<C-e>"] = { "scroll_documentation_down", "fallback" },
      ["<C-y>"] = { "scroll_documentation_up", "fallback" },

      ["<CR>"] = {},
    },
  },
}
