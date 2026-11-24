{
  lib,
  pkgs,
  lua,
  ...
}: {
  config.vim = {
    extraPackages = with pkgs; [
      oxfmt
      oxlint
      blade-formatter
    ];

    lsp = {
      enable = true;
      formatOnSave = true;

      servers.oxlint = {
        enable = true;
        cmd = [(lib.getExe pkgs.oxlint) "--lsp"];
        filetypes = [
          "javascript"
          "javascriptreact"
          "typescript"
          "typescriptreact"
          "vue"
          "svelte"
          "astro"
        ];
        root_markers = [
          ".git"
          "package.json"
          ".oxlintrc.json"
          ".oxlintrc.jsonc"
          "oxlint.config.ts"
        ];
        on_attach = lua ''
          function(client, bufnr)
            vim.api.nvim_buf_create_user_command(bufnr, "LspOxlintFixAll", function()
              client:exec_cmd({
                title = "Apply Oxlint automatic fixes",
                command = "oxc.fixAll",
                arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
              })
            end, { desc = "Apply Oxlint automatic fixes" })
          end
        '';
      };

      presets = {
        tailwindcss-language-server.enable = true;
      };

      trouble = {
        enable = true;
        setupOpts.modes.lsp.win.position = "right";
        mappings = {
          workspaceDiagnostics = null;
          documentDiagnostics = null;
          lspReferences = null;
          quickfix = null;
          locList = null;
          symbols = null;
        };
      };
    };

    formatter.conform-nvim = {
      enable = true;

      setupOpts = {
        formatters = {
          blade-formatter = {
            command = lib.getExe pkgs.blade-formatter;
            args = ["--stdin"];
            stdin = true;
          };

          oxfmt.command = lib.getExe pkgs.oxfmt;
        };

        formatters_by_ft = {
          blade = ["blade-formatter"];
          css = ["oxfmt"];
          html = ["oxfmt"];
          javascript = ["oxfmt"];
          javascriptreact = ["oxfmt"];
          json = ["oxfmt"];
          json5 = ["oxfmt"];
          jsonc = ["oxfmt"];
          less = ["oxfmt"];
          markdown = ["oxfmt"];
          scss = ["oxfmt"];
          toml = ["oxfmt"];
          typescript = ["oxfmt"];
          typescriptreact = ["oxfmt"];
          vue = ["oxfmt"];
          yaml = ["oxfmt"];
        };
      };
    };

    languages = {
      enableFormat = true;
      enableTreesitter = true;

      nix.enable = true;
      terraform.enable = true;

      rust = {
        enable = true;

        extensions = {
          rustaceanvim.enable = true;
          crates-nvim.enable = true;
        };

        # rustaceanvim manages its own rust-analyzer
        lsp.enable = false;
      };

      markdown = {
        enable = true;
        format.enable = false; # use oxfmt
        extensions = {
          render-markdown-nvim.enable = true;
        };
      };

      toml = {
        enable = true;
        lsp.servers = ["tombi"];
        format.enable = false; # use oxfmt
      };

      php = {
        enable = true;
        lsp.servers = ["phpantom"];
        format.enable = false; # use phpantom
      };

      json = {
        enable = true;
        format.enable = false; # use oxfmt
      };

      vue = {
        enable = true;
        format.enable = false; # use oxfmt
      };

      typescript = {
        enable = true;
        format.enable = false; # use oxfmt
        lsp.servers = ["typescript-go"];
      };

      yaml = {
        enable = true;
        format.enable = false; # use oxfmt
      };

      html = {
        enable = true;
        format.enable = false; # use oxfmt
        lsp.enable = false;
        treesitter.autotagHtml = true;
      };

      css = {
        enable = true;
        format.enable = false; # use oxfmt
      };
    };

    keymaps = [
      # lsp
      {
        mode = ["n" "v" "i"];
        key = "<A-,>";
        lua = true;
        desc = "Show signature help";
        action = "vim.lsp.buf.signature_help";
      }
      {
        mode = ["n" "v" "i"];
        key = "<A-.>";
        lua = true;
        desc = "Show hover";
        action = "vim.lsp.buf.hover";
      }
      {
        mode = "n";
        key = "gd";
        lua = true;
        desc = "To definition";
        action = "vim.lsp.buf.definition";
      }
      {
        mode = "n";
        key = "g/";
        lua = true;
        desc = "To references";
        action = "vim.lsp.buf.references";
      }
      {
        mode = "n";
        key = "gi";
        lua = true;
        desc = "To implementation";
        action = "vim.lsp.buf.implementation";
      }
      {
        mode = "n";
        key = "<leader>ca";
        lua = true;
        desc = "Code Action";
        action = "vim.lsp.buf.code_action";
      }
      {
        mode = "n";
        key = "<leader>cl";
        action = "<cmd>checkhealth vim.lsp<cr>";
        desc = "LSP Info";
      }

      # format
      {
        mode = ["n" "v"];
        key = "<A-f>";
        lua = true;
        desc = "Format";
        action = ''function() require("conform").format({ lsp_format = "fallback" }) end'';
      }

      # markdown
      {
        mode = "n";
        key = "<leader>um";
        lua = true;
        desc = "Toggle Render Markdown";
        action = ''function() require("render-markdown").toggle() end'';
      }

      # trouble
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        desc = "Diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xX";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
        desc = "Buffer Diagnostics (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>cs";
        action = "<cmd>Trouble symbols toggle<cr>";
        desc = "Symbols (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>cS";
        action = "<cmd>Trouble lsp toggle<cr>";
        desc = "LSP references/definitions/... (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xi";
        action = "<cmd>Trouble loclist toggle<cr>";
        desc = "Location List (Trouble)";
      }
      {
        mode = "n";
        key = "<leader>xo";
        action = "<cmd>Trouble qflist toggle<cr>";
        desc = "Quickfix List (Trouble)";
      }
      {
        mode = "n";
        key = "[o";
        lua = true;
        desc = "Previous Trouble/Quickfix Item";
        action = ''
          function()
            local trouble = require("trouble")
            if trouble.is_open() then
              trouble.prev({ skip_groups = true, jump = true })
            else
              local ok, err = pcall(vim.cmd.cprev)
              if not ok then
                vim.notify(err, vim.log.levels.ERROR)
              end
            end
          end
        '';
      }
      {
        mode = "n";
        key = "]o";
        lua = true;
        desc = "Next Trouble/Quickfix Item";
        action = ''
          function()
            local trouble = require("trouble")
            if trouble.is_open() then
              trouble.next({ skip_groups = true, jump = true })
            else
              local ok, err = pcall(vim.cmd.cnext)
              if not ok then
                vim.notify(err, vim.log.levels.ERROR)
              end
            end
          end
        '';
      }
    ];

    luaConfigRC.lsp-folding = lib.nvim.dag.entryAfter ["basic"] ''
      local ts_foldexpr = "v:lua.vim.treesitter.foldexpr()"
      local lsp_foldexpr = "v:lua.vim.lsp.foldexpr()"

      local function apply_fold(buf, detaching)
        local has_lsp = false
        for _, client in ipairs(vim.lsp.get_clients({
          bufnr = buf,
          method = "textDocument/foldingRange",
        })) do
          if client.id ~= detaching then
            has_lsp = true
            break
          end
        end

        for _, win in ipairs(vim.fn.win_findbuf(buf)) do
          if has_lsp then
            vim.wo[win].foldmethod = "expr"
            vim.wo[win].foldexpr = lsp_foldexpr
          elseif vim.wo[win].foldexpr == lsp_foldexpr then
            -- Revert inherited LSP folding, but leave unrelated buffers
            -- (help, diff, ...) and their fold settings alone.
            vim.wo[win].foldmethod = "expr"
            vim.wo[win].foldexpr = ts_foldexpr
          end
        end
      end

      vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach", "BufWinEnter" }, {
        desc = "Prefer LSP folding if the client supports it",
        callback = function(args)
          -- LspDetach fires before the client is removed, so ignore it explicitly
          local detaching = args.event == "LspDetach" and args.data.client_id or nil
          apply_fold(args.buf, detaching)
        end,
      })
    '';
  };
}
