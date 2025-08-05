-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.clipboard = ""

vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.opt.showtabline = 0

vim.g.snacks_animate = false

-- Disable auto comments when opening a new line
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

-- Folding
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldtext = ""
vim.opt.foldcolumn = "0"
vim.opt.fillchars:append({ fold = " " })
vim.o.foldmethod = "expr"

-- Default to treesitter folding
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Prefer LSP folding if client supports it
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method("textDocument/foldingRange") then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end
  end,
})

-- Find the project root directory name (e.g., "neovim" from "/path/to/neovim")
local function GetProjectName()
  local markers = { ".git", "flake.nix" }
  local dir = vim.fn.expand("%:p:h") -- Current file's directory

  -- Search upwards for a project marker
  for _, marker in ipairs(markers) do
    local found = vim.fn.findfile(marker, dir .. ";")
    if found ~= "" then
      -- Extract the parent directory name (project root folder name)
      local project_root = vim.fn.fnamemodify(found, ":p:h")
      return vim.fn.fnamemodify(project_root, ":t") -- :t = tail (last component)
    end
  end

  return nil -- No project root found
end

-- Format the title as "filename [project]"
function FormatTitle()
  local filename = vim.fn.expand("%:t") -- Current filename
  local project = GetProjectName()

  if project then
    return string.format("%s [%s]", filename, project)
  else
    return filename -- Fallback: just the filename
  end
end

-- Dynamic Title
vim.o.title = true
vim.o.titlestring = "%{%v:lua.FormatTitle()%}"

vim.g.lazyvim_rust_diagnostics = "bacon-ls"

local function get_vue_plugin_path()
  local handle = io.popen("dirname $(dirname $(readlink -f $(which vue-language-server)))")
  if handle then
    local result = handle:read("*a"):gsub("%s+", "") -- remove newlines
    handle:close()
    return result .. "/lib/language-tools/packages/language-server"
  end
  return nil
end

local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = get_vue_plugin_path(),
  languages = { "vue" },
  configNamespace = "typescript",
}

vim.lsp.config["vtsls"] = {
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
  },

  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
}

vim.lsp.enable("vtsls")
vim.lsp.enable("vue_ls")
