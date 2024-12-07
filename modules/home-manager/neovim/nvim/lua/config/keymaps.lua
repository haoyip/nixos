-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

-- typo helpers
do
  vim.api.nvim_create_user_command("Q", function()
    vim.api.nvim_exec2("q", {})
  end, {})

  vim.api.nvim_create_user_command("W", function()
    vim.api.nvim_exec2("w", {})
  end, {})

  vim.api.nvim_create_user_command("Qw", function()
    vim.api.nvim_exec2("qw", {})
  end, {})

  vim.api.nvim_create_user_command("Qa", function()
    vim.api.nvim_exec2("qa", {})
  end, {})
end

-- unset move line for normal mode and insert mode
vim.keymap.set({ "n", "i" }, "<A-j>", "")
vim.keymap.set({ "n", "i" }, "<A-k>", "")

-- view command histories
vim.keymap.set("c", "<A-j>", "<Down>")
vim.keymap.set("c", "<A-k>", "<Up>")

-- buffers
vim.keymap.set({ "n", "i", "v" }, "<A-a>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set({ "n", "i", "v" }, "<A-d>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- folding
vim.keymap.set("n", "<A-e>", "zc", { desc = "Close fold under cursor" })
vim.keymap.set("n", "<A-r>", "zo", { desc = "Open fold under cursor" })

-- after yanking in visual mode, stay on cursor
vim.keymap.set("v", "y", "ygv<Esc>")

-- comments
vim.keymap.set("v", "<A-/>", "gcj", { remap = true })
vim.keymap.set("n", "<A-/>", "gccj", { remap = true })
vim.keymap.set("i", "<A-/>", "<Esc>gccji", { remap = true })

-- select all, copy, paste
vim.keymap.set({ "n" }, "<leader><C-a>", "ggVG", { desc = "Selet all" })
vim.keymap.set({ "n" }, "<C-c>", '"+yy', { desc = "Copy to system clipboard" })
vim.keymap.set({ "v" }, "<C-c>", '"+ygv<Esc>', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "v" }, "<C-v>", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "i" }, "<C-v>", '<esc>"+pa', { desc = "Paste from system clipboard" })
vim.keymap.set({ "c" }, "<C-v>", "<C-r>+", { desc = "Paste from system clipboard" })

--  rebind v-block
vim.keymap.set({ "n", "v" }, "<leader><C-v>", "<C-v>", { desc = "v-block" })

-- insert mode delete motion
vim.keymap.set("i", "<C-l>", "<Del>", { desc = "Delete a character after the cursor" })
vim.keymap.set("i", "<C-d>", "<esc>ldwi", { desc = "Delete a word after the cursor" })

-- format
vim.keymap.set({ "n", "v" }, "<A-f>", function()
  Util.format({ force = true })
end, { desc = "Format" })

-- lsp
vim.keymap.set("n", "<A-i>", vim.lsp.buf.hover, { desc = "Show hover" })
vim.keymap.set("n", "<A-o>", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- window
vim.keymap.set("n", "<C-A-w>", "<C-w>c", { desc = "Delete Window" })

-- change inner word
vim.keymap.set("n", "<A-c>", "ciw", { desc = "Change inner Word" })
vim.keymap.set("n", "<A-C>", "ciW", { desc = "Change inner WORD" })

-- quick type
vim.keymap.set("i", "<A-f>", "->", { desc = "Quick '->'" })
vim.keymap.set("i", "<A-g>", "<space>=><space>", { desc = "Quick ' => '" })
vim.keymap.set("i", "<A-e>", "$", { desc = "Quick '$'" })

-- quick navigate
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
