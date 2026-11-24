{lua, ...}: {
  config.vim = {
    statusline.lualine = {
      enable = true;
      setupOpts = {
        options = {
          theme = "auto";
          globalstatus = true;
          component_separators = {
            left = "";
            right = "";
          };
        };

        sections = {
          lualine_a = ["mode"];
          lualine_b = ["branch"];

          lualine_c = [
            (lua ''
              {
                function()
                  local reg = vim.fn.reg_recording()
                  if reg == "" then
                    return ""
                  end
                  return "MACRO " .. reg
                end,
                color = "DiagnosticWarn",
                padding = { left = 1, right = 0 },
              }
            '')
            {
              "@1" = "filetype";
              icon_only = true;
              separator = "";
              padding = {
                left = 1;
                right = 0;
              };
            }
            {
              "@1" = "filename";
              path = 1;
              padding = {
                left = 0;
                right = 0;
              };
            }
            {
              "@1" = "diagnostics";
              symbols = {
                error = " ";
                warn = " ";
                info = " ";
                hint = "󰌵 ";
              };
            }
          ];

          lualine_x = [
            "lsp_status"
            {
              "@1" = "diff";
              symbols = {
                added = "+";
                modified = "~";
                removed = "-";
              };
            }
          ];

          lualine_y = [
            {
              "@1" = "searchcount";
              padding = {
                left = 1;
                right = 0;
              };
            }
            {
              "@1" = "location";
              padding = {
                left = 0;
                right = 1;
              };
            }
          ];

          lualine_z = ["tabs"];
        };
      };
    };

    opts = {
      showtabline = 0;
    };
  };
}
