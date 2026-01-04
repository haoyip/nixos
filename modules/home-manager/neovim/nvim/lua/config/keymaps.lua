-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

local base_font_size = 11
local current_font_size = base_font_size

local base_tracking = -1
local current_tracking = base_tracking

if vim.g.neovide then
  function IncreaseFontSize()
    SetFont(current_font_size + 1, current_tracking)
  end

  function DecreaseFontSize()
    SetFont(current_font_size - 1, current_tracking)
  end

  function IncreaseTracking()
    SetFont(current_font_size, current_tracking + 0.5)
  end

  function DecreaseTracking()
    SetFont(current_font_size, current_tracking - 0.5)
  end

  function SetFont(size, tracking)
    current_font_size = size
    current_tracking = tracking
    vim.opt.guifont = "Maple Mono NF:h" .. current_font_size .. ":w" .. current_tracking
    vim.opt.linespace = -2
  end

  vim.keymap.set({ "n", "v", "c" }, "<C-=>", ":lua IncreaseFontSize()<CR>")
  vim.keymap.set({ "n", "v", "c" }, "<C-->", ":lua DecreaseFontSize()<CR>")
  vim.keymap.set({ "n", "v", "c" }, "<C-ScrollWheelUp>", ":lua IncreaseFontSize()<CR>")
  vim.keymap.set({ "n", "v", "c" }, "<C-ScrollWheelDown>", ":lua DecreaseFontSize()<CR>")
  vim.keymap.set({ "i" }, "<C-=>", "<esc>:lua IncreaseFontSize()<CR>a")
  vim.keymap.set({ "i" }, "<C-->", "<esc>:lua DecreaseFontSize()<CR>a")
  vim.keymap.set({ "i" }, "<C-ScrollWheelUp>", "<esc>:lua IncreaseFontSize()<CR>a")
  vim.keymap.set({ "i" }, "<C-ScrollWheelDown>", "<esc>:lua DecreaseFontSize()<CR>a")

  vim.keymap.set({ "n", "v", "c" }, "<C-A-=>", ":lua IncreaseTracking()<CR>")
  vim.keymap.set({ "n", "v", "c" }, "<C-A-->", ":lua DecreaseTracking()<CR>")
  vim.keymap.set({ "n", "v", "c" }, "<C-A-ScrollWheelUp>", ":lua IncreaseTracking()<CR>")
  vim.keymap.set({ "n", "v", "c" }, "<C-A-ScrollWheelDown>", ":lua DecreaseTracking()<CR>")
  vim.keymap.set({ "i" }, "<C-A-=>", "<esc>:lua IncreaseTracking()<CR>a")
  vim.keymap.set({ "i" }, "<C-A->", "<esc>:lua DecreaseTracking()<CR>a")
  vim.keymap.set({ "i" }, "<C-A-ScrollWheelUp>", "<esc>:lua IncreaseTracking()<CR>a")
  vim.keymap.set({ "i" }, "<C-A-ScrollWheelDown>", "<esc>:lua DecreaseTracking()<CR>a")

  vim.keymap.set({ "n", "v", "c" }, "<C-0>", ":lua SetFont(" .. base_font_size .. "," .. base_tracking .. ")<CR>")
  vim.keymap.set({ "i" }, "<C-0>", "<esc>:lua SetFont(" .. base_font_size .. "," .. base_tracking .. ")<CR>a")

  SetFont(base_font_size, base_tracking)

  vim.keymap.set("n", "<leader>e", function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end, { desc = "Toggle Neovide Fullscreen" })
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
vim.keymap.set("c", "<C-j>", "<Down>")
vim.keymap.set("c", "<C-k>", "<Up>")

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

-- delete line
vim.keymap.set("n", "<A-x>", "dd", { desc = "Delete line" })

-- quick type
vim.keymap.set("i", "<A-f>", "->", { desc = "Quick '->'" })
vim.keymap.set("i", "<A-g>", "<space>=><space>", { desc = "Quick ' => '" })
vim.keymap.set("i", "<A-e>", "$", { desc = "Quick '$'" })

-- quick navigate
vim.keymap.set({ "n", "v" }, "H", "^", { remap = true })
vim.keymap.set({ "n", "v" }, "L", "$", { remap = true })

-- center screeen after page up/down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- tab
vim.keymap.set("n", "<A-T>", "<cmd>tabnew %<cr>", { desc = "New tab" })
vim.keymap.set("n", "<A-D>", "<cmd>tabclose<cr>", { desc = "Close tab" })
vim.keymap.set("n", "<A-L>", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "<A-H>", "<cmd>tabprevious<cr>", { desc = "Previous tab" })
vim.keymap.set("n", "<A-O>", "<cmd>tabonly<cr>", { desc = "Close all other tabs" })

-- quick switch windows
vim.keymap.set("n", "<Tab>", "<C-w>w", { desc = "Switch Windows" })

-- not sure which plugin is overwriting this...
vim.keymap.set("n", "<C-i>", "<C-i>", { desc = "Jump to newer position" })

-- no terminal
vim.keymap.set("n", "<C-/>", "", { remap = true })

vim.keymap.set("n", "<A-j>", "<C-down>", { remap = true })
vim.keymap.set("n", "<A-k>", "<C-up>", { remap = true })

-- search within visual selection
vim.keymap.set("x", "/", "<Esc>/\\%V")

-- tiny code action
vim.keymap.set("n", "<leader>cw", function()
  require("tiny-code-action").code_action()
end)

-- open file explorer on root dir
vim.keymap.set("n", "<leader>fo", ":!xdg-open .<cr>")

-- open file explorer on current buffer
vim.keymap.set("n", "<leader>fO", ":!xdg-open %:p:h<cr>")

-- scroll up down faster
vim.keymap.set("n", "<C-E>", "3<C-E>")
vim.keymap.set("n", "<C-Y>", "3<C-Y>")
