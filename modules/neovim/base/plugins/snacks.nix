{lua, ...}: {
  config.vim = {
    globals.snacks_animate = false;

    utility.snacks-nvim = {
      enable = true;
      setupOpts = {
        dashboard = {
          enabled = true;
          preset = {
            header = "";
            keys = [
              {
                icon = " ";
                key = "f";
                desc = "Find File";
                action = ":lua Snacks.dashboard.pick('files')";
              }
              {
                icon = " ";
                key = "n";
                desc = "New File";
                action = ":ene | startinsert";
              }
              {
                icon = " ";
                key = "/";
                desc = "Find Text";
                action = ":lua Snacks.dashboard.pick('live_grep')";
              }
              {
                icon = " ";
                key = "r";
                desc = "Recent Files";
                action = ":lua Snacks.dashboard.pick('oldfiles')";
              }
              {
                icon = " ";
                key = "s";
                desc = "Restore Session";
                action = ":lua require('persistence').load()";
              }
              {
                icon = " ";
                key = "q";
                desc = "Quit";
                action = ":qa";
              }
            ];
          };
          sections = [
            {
              section = "keys";
              gap = 1;
              padding = 1;
            }
          ];
        };

        picker = {
          enabled = true;
          win.input.keys = {
            "<C-c>" = ["disabled"];
            "<C-v>" = ["disabled"];
            "<C-w>" = lua ''{ "edit_vsplit", mode = { "i", "n" } }'';
            "<a-j>" = lua ''{ "list_down", mode = { "i", "n" } }'';
            "<a-k>" = lua ''{ "list_up", mode = { "i", "n" } }'';
          };
        };

        indent.enabled = true;
        bigfile.enabled = true;
        quickfile.enabled = true;

        words = {
          enabled = true;
          debounce = 50;
        };

        statuscolumn = {
          enabled = true;
          folds = {
            open = true;
            git_hl = true;
          };
        };
      };
    };

    keymaps = [
      # picker
      {
        mode = "n";
        key = "<leader>k";
        lua = true;
        desc = "Picker: Files";
        action = "function() Snacks.picker.files({}) end";
      }
      {
        mode = "n";
        key = "<leader>/";
        lua = true;
        desc = "Picker: Grep";
        action = "function() Snacks.picker.grep({}) end";
      }
      {
        mode = "n";
        key = "<leader>uC";
        lua = true;
        desc = "Picker: Colorschemes";
        action = "function() Snacks.picker.colorschemes({}) end";
      }
      {
        mode = "n";
        key = "<leader>bb";
        lua = true;
        desc = "Picker: Buffers";
        action = "function() Snacks.picker.buffers({}) end";
      }

      # toggle
      {
        mode = "n";
        key = "<leader>us";
        lua = true;
        desc = "Spelling";
        action = ''function() Snacks.toggle.option("spell", { name = "Spelling" }):toggle() end'';
      }
      {
        mode = "n";
        key = "<leader>dph";
        lua = true;
        desc = "Profiler Highlights";
        action = "function() Snacks.toggle.profiler_highlights():toggle() end";
      }
      {
        mode = "n";
        key = "<leader>uw";
        lua = true;
        desc = "Wrap";
        action = ''function() Snacks.toggle.option("wrap", { name = "Wrap" }):toggle() end'';
      }
      {
        mode = "n";
        key = "<leader>uL";
        lua = true;
        desc = "Relative Number";
        action = ''function() Snacks.toggle.option("relativenumber", { name = "Relative Number" }):toggle() end'';
      }
      {
        mode = "n";
        key = "<leader>ud";
        lua = true;
        desc = "Diagnostics";
        action = "function() Snacks.toggle.diagnostics():toggle() end";
      }
      {
        mode = "n";
        key = "<leader>ul";
        lua = true;
        desc = "Line Number";
        action = "function() Snacks.toggle.line_number():toggle() end";
      }
      {
        mode = "n";
        key = "<leader>uc";
        lua = true;
        desc = "Conceal Level";
        action = ''function() Snacks.toggle.option("conceallevel", { off = 0, on = 2, name = "Conceal Level" }):toggle() end'';
      }
      {
        mode = "n";
        key = "<leader>uA";
        lua = true;
        desc = "Tabline";
        action = ''function() Snacks.toggle.option("showtabline", { off = 0, on = 2, name = "Tabline" }):toggle() end'';
      }
      {
        mode = "n";
        key = "<leader>ub";
        lua = true;
        desc = "Dark Background";
        action = ''function() Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):toggle() end'';
      }
      {
        mode = "n";
        key = "<leader>uD";
        lua = true;
        desc = "Dim";
        action = "function() Snacks.toggle.dim():toggle() end";
      }
      {
        mode = "n";
        key = "<leader>ug";
        lua = true;
        desc = "Indent";
        action = "function() Snacks.toggle.indent():toggle() end";
      }
      {
        mode = "n";
        key = "<leader>dpp";
        lua = true;
        desc = "Profiler";
        action = "function() Snacks.toggle.profiler():toggle() end";
      }
      {
        mode = "n";
        key = "<leader>uh";
        lua = true;
        desc = "Inlay Hints";
        action = "function() Snacks.toggle.inlay_hints():toggle() end";
      }
      {
        mode = "n";
        key = "<leader>uz";
        lua = true;
        desc = "Zen";
        action = "function() Snacks.toggle.zen():toggle() end";
      }

      # git
      {
        mode = "n";
        key = "<leader>gl";
        lua = true;
        desc = "Git Log";
        action = ''
          function()
            local cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
            if cwd then
              Snacks.picker.git_log({ cwd = cwd })
            else
              Snacks.picker.git_log()
            end
          end
        '';
      }
      {
        mode = "n";
        key = "<leader>gL";
        lua = true;
        desc = "Git Log (cwd)";
        action = "function() Snacks.picker.git_log() end";
      }
      {
        mode = "n";
        key = "<leader>gb";
        lua = true;
        desc = "Git Blame Line";
        action = "function() Snacks.picker.git_log_line() end";
      }
      {
        mode = "n";
        key = "<leader>gf";
        lua = true;
        desc = "Git Current File History";
        action = "function() Snacks.picker.git_log_file() end";
      }
      {
        mode = ["n" "x"];
        key = "<leader>gB";
        lua = true;
        desc = "Git Browse (open)";
        action = "function() Snacks.gitbrowse() end";
      }
      {
        mode = ["n" "x"];
        key = "<leader>gY";
        lua = true;
        desc = "Git Browse (copy)";
        action = ''
          function()
            Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false })
          end
        '';
      }
    ];
  };
}
