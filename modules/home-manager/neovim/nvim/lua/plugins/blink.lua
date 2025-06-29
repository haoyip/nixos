return {
  "saghen/blink.cmp",

  dependencies = { "archie-judd/blink-cmp-words" },

  opts = {
    keymap = {
      preset = "enter",
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-h>"] = { "hide", "fallback" },
      ["<C-l>"] = { "accept", "fallback" },
      ["<C-e>"] = { "scroll_documentation_down", "fallback" },
      ["<C-y>"] = { "scroll_documentation_up", "fallback" },

      ["<A-j>"] = { "select_next", "fallback" },
      ["<A-k>"] = { "select_prev", "fallback" },
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

    sources = {
      default = { "lsp", "path", "lazydev" },
      providers = {
        dictionary = {
          name = "blink-cmp-words",
          module = "blink-cmp-words.dictionary",
          -- All available options
          opts = {
            -- The number of characters required to trigger completion.
            dictionary_search_threshold = 3,

            -- See above
            score_offset = 0,

            -- See above
            pointer_symbols = { "!", "&", "^" },
          },
        },
      },

      per_filetype = {
        text = { "dictionary" },
        markdown = { "dictionary" },
      },
    },
  },
}
