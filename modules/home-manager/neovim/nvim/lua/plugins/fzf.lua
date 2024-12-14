return {
  "ibhagwan/fzf-lua",
  opts = function(_, opts)
    local config = require("fzf-lua.config")

    config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
    config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
    config.defaults.keymap.fzf["ctrl-x"] = "jump"
    config.defaults.keymap.fzf["ctrl-e"] = "preview-page-down"
    config.defaults.keymap.fzf["ctrl-y"] = "preview-page-up"
    config.defaults.keymap.builtin["<c-e>"] = "preview-page-down"
    config.defaults.keymap.builtin["<c-y>"] = "preview-page-up"

    require("fzf-lua").setup(opts)
  end,
}
