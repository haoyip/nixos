-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

if vim.g.neovide then
  local guifontsize = 11

  function IncreaseFontSize()
    SetFontSize(guifontsize + 1)
  end

  function DecreaseFontSize()
    SetFontSize(guifontsize - 1)
  end

  function SetFontSize(size)
    guifontsize = size
    vim.opt.guifont = "JetBrainsMono Nerd Font:h" .. guifontsize
  end

  vim.keymap.set({ "n", "i", "v", "c" }, "<C-=>", ":lua IncreaseFontSize()<CR>")
  vim.keymap.set({ "n", "i", "v", "c" }, "<C-->", ":lua DecreaseFontSize()<CR>")
  vim.keymap.set({ "n", "i", "v", "c" }, "<C-0>", ":lua SetFontSize(11)<CR>")

  vim.keymap.set({ "n", "i", "v", "c" }, "<C-ScrollWheelUp>", ":lua IncreaseFontSize()<CR>")
  vim.keymap.set({ "n", "i", "v", "c" }, "<C-ScrollWheelDown>", ":lua DecreaseFontSize()<CR>")

  SetFontSize(11)
end

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

-- folding
vim.keymap.set("n", "<A-e>", "zc", { desc = "Close fold under cursor" })
vim.keymap.set("n", "<A-r>", "zo", { desc = "Open fold under cursor" })

-- after yanking in visual mode, stay on cursor
vim.keymap.set("v", "y", "ygv<Esc>")

-- comments
vim.keymap.set("v", "<A-/>", "gcj", { remap = true })
vim.keymap.set("n", "<A-/>", "gccj", { remap = true })
vim.keymap.set("i", "<A-/>", "<Esc>gccji", { remap = true })

-- duplicate line, comments old line, keep cursor position
vim.keymap.set("v", "<A-S-/>", "<Esc>mzyygccp`z:delmarks z<cr>jV", { remap = true })
vim.keymap.set("n", "<A-S-/>", "mzyygccp`z:delmarks z<cr>j", { remap = true })
vim.keymap.set("i", "<A-S-/>", "<Esc>mzyygccp`z:delmarks z<cr>ja", { remap = true })

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

-- select inner word
vim.keymap.set("n", "<A-v>", "viw", { desc = "Select inner Word" })
vim.keymap.set("n", "<A-V>", "viW", { desc = "Select inner WORD" })

-- quick type
vim.keymap.set("i", "<A-f>", "->", { desc = "Quick '->'" })
vim.keymap.set("i", "<A-g>", "<space>=><space>", { desc = "Quick ' => '" })
vim.keymap.set("i", "<A-e>", "$", { desc = "Quick '$'" })

-- quick navigate
vim.keymap.set({ "n", "v" }, "H", "^")
vim.keymap.set({ "n", "v" }, "L", "$")
vim.keymap.set({ "n", "i" }, "<A-l>", "<esc>la")
vim.keymap.set({ "n", "i" }, "<A-h>", "<esc>i")

-- center screeen after page up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew %<cr>", { desc = "New tab" })
vim.keymap.set("n", "<leader>td", "<cmd>tabclose<cr>", { desc = "Close tab" })
vim.keymap.set("n", "<A-H>", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<A-L>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<cr>", { desc = "Close all other tabs" })

-- quick switch windows
vim.keymap.set("n", "<Tab>", "<C-w>w", { desc = "Switch Windows" })

-- not sure which plugin is overwriting this...
vim.keymap.set("n", "<C-i>", "<C-i>", { desc = "Jump to newer position" })

-- no terminal
vim.keymap.set("n", "<C-/>", "", { remap = true })

vim.keymap.set("n", "<A-j>", "<C-down>", { remap = true })
vim.keymap.set("n", "<A-k>", "<C-up>", { remap = true })
