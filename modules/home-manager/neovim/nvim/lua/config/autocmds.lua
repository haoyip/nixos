-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Open help in vertical split
vim.cmd("autocmd! FileType help wincmd L")

-- keep window position when switching buffers
vim.cmd("autocmd! BufLeave * let b:winview = winsaveview()")
vim.cmd("autocmd! BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif")
