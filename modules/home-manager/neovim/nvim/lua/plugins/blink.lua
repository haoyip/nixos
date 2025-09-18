return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "enter",
      ["<C-e>"] = { "scroll_documentation_down", "fallback" },
      ["<C-y>"] = { "scroll_documentation_up", "fallback" },

      ["<A-j>"] = { "select_next", "fallback" },
      ["<A-k>"] = { "select_prev", "fallback" },
      ["<A-h>"] = { "hide", "fallback" },
      ["<A-l>"] = { "accept", "fallback" },

      ["<CR>"] = {},

      ["<A-i>"] = {
        function(cmp)
          cmp.show({ providers = { "lsp" } })
        end,
      },

      ["<A-s>"] = {
        function(cmp)
          cmp.show({ providers = { "snippets" } })
        end,
      },
    },

    cmdline = {
      keymap = {
        preset = "inherit",
      },
    },
  },
}
