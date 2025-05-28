-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Open help in vertical split
vim.cmd("autocmd! FileType help wincmd L")

-- keep window position when switching buffers
vim.cmd("autocmd! BufLeave * let b:winview = winsaveview()")
vim.cmd("autocmd! BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif")

-- no scroll when switching buffers
if vim.g.neovide then
  local scroll_length = 0.125
  vim.g.neovide_scroll_animation_length = scroll_length

  vim.api.nvim_create_autocmd("BufLeave", {
    callback = function()
      vim.g.neovide_scroll_animation_length = 0
    end,
  })

  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
      vim.fn.timer_start(70, function()
        vim.g.neovide_scroll_animation_length = scroll_length
      end)
    end,
  })

  vim.cmd("colorscheme evergarden-fall")
end
