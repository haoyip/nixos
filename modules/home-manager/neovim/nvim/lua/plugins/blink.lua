return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<A-j>"] = { "select_next", "fallback" },
        ["<A-k>"] = { "select_prev", "fallback" },
        ["<A-h>"] = { "hide", "fallback" },
        ["<A-l>"] = { "accept", "fallback" },
        ["<C-e>"] = { "scroll_documentation_down", "fallback" },
        ["<C-y>"] = { "scroll_documentation_up", "fallback" },
      },
    },
  },
}
