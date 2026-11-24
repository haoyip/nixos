{lua, ...}: {
  config.vim = {
    augroups = map (name: {inherit name;}) [
      "checktime"
      "highlight_yank"
      "resize_splits"
      "last_loc"
      "man_unlisted"
      "wrap_spell"
      "json_conceal"
      "auto_create_dir"
    ];

    autocmds = [
      # open help and man (keywordprg) in vertical split
      {
        event = ["FileType"];
        pattern = ["help" "man"];
        command = "wincmd L";
      }

      # keep window position when switching buffers
      {
        event = ["BufLeave"];
        command = "let b:winview = winsaveview()";
      }
      {
        event = ["BufEnter"];
        command = "if exists('b:winview') | call winrestview(b:winview) | endif";
      }

      # check if we need to reload the file when it changed
      {
        group = "checktime";
        event = ["FocusGained" "TermClose" "TermLeave"];
        callback = lua ''
          function()
            if vim.opt.buftype ~= "nofile" then
              vim.cmd("checktime")
            end
          end
        '';
      }

      # highlight on yank
      {
        group = "highlight_yank";
        event = ["TextYankPost"];
        callback = lua ''
          function()
            vim.highlight.on_yank()
          end
        '';
      }

      # resize splits if window got resized
      {
        group = "resize_splits";
        event = ["vimresized"];
        callback = lua ''
          function()
            local current_tab = vim.fn.tabpagenr()
            vim.cmd("tabdo wincmd =")
            vim.cmd("tabnext " .. current_tab)
          end
        '';
      }

      # go to last loc when opening a buffer
      {
        group = "last_loc";
        event = ["BufReadPost"];
        callback = lua ''
          function(event)
            local exclude = { "gitcommit" }
            local buf = event.buf
            if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then
              return
            end
            vim.b[buf].last_loc = true
            local mark = vim.api.nvim_buf_get_mark(buf, '"')
            local lcount = vim.api.nvim_buf_line_count(buf)
            if mark[1] > 0 and mark[1] <= lcount then
              pcall(vim.api.nvim_win_set_cursor, 0, mark)
            end
          end
        '';
      }

      # make it easier to close man-files when opened inline
      {
        group = "man_unlisted";
        event = ["FileType"];
        pattern = ["man"];
        callback = lua ''
          function(event)
            vim.bo[event.buf].buflisted = false
          end
        '';
      }

      # wrap and check for spell in text filetypes
      {
        group = "wrap_spell";
        event = ["FileType"];
        pattern = ["text" "plaintex" "typst" "gitcommit" "markdown"];
        callback = lua ''
          function()
            vim.opt_local.wrap = true
            vim.opt_local.spell = true
          end
        '';
      }

      # fix conceallevel for json files
      {
        group = "json_conceal";
        event = ["FileType"];
        pattern = ["json" "jsonc" "json5"];
        callback = lua ''
          function()
            vim.opt_local.conceallevel = 0
          end
        '';
      }

      # auto create dir when saving a file, in case some intermediate directory does not exist
      {
        group = "auto_create_dir";
        event = ["BufWritePre"];
        callback = lua ''
          function(event)
            if event.match:match("^%w%w+:[\\/][\\/]") then
              return
            end
            local file = vim.uv.fs_realpath(event.match) or event.match
            vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
          end
        '';
      }

      # q key to close
      {
        event = ["FileType"];
        pattern = ["help" "man" "qf" "lspinfo" "checkhealth" "startuptime"];
        callback = lua ''
          function(args)
            vim.keymap.set("n", "q", "<cmd>close<cr>", {
              buffer = args.buf,
              silent = true,
              desc = "Close special buffer",
            })
          end
        '';
      }
    ];
  };
}
