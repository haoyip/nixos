{lib, ...}: {
  config.vim = {
    opts = {
      title = true;
      titlestring = "%{%v:lua.FormatTitle()%}";
    };

    luaConfigRC = {
      title = lib.nvim.dag.entryAnywhere ''
        local function GetProjectName()
          local markers = { ".git", "flake.nix" }
          local dir = vim.fn.expand("%:p:h")

          for _, marker in ipairs(markers) do
            local found = vim.fn.findfile(marker, dir .. ";")
            if found ~= "" then
              local project_root = vim.fn.fnamemodify(found, ":p:h")
              return vim.fn.fnamemodify(project_root, ":t")
            end
          end
          return nil
        end

        function FormatTitle()
          local filename = vim.fn.expand("%:t")
          local project = GetProjectName()
          if project then
            return string.format("%s [%s]", filename, project)
          end
          return filename
        end
      '';
    };
  };
}
