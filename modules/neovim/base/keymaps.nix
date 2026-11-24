{...}: {
  config.vim = {
    globals = {
      mapleader = " ";
      maplocalleader = "\\";
    };

    keymaps = [
      # leader key
      {
        mode = ["n" "v"];
        key = " ";
        action = "";
      }

      # bracket key
      {
        mode = "n";
        key = "<A-n>";
        action = "]";
        noremap = false;
      }
      {
        mode = "n";
        key = "<A-p>";
        action = "[";
        noremap = false;
      }

      # save
      {
        mode = ["i" "x" "n" "s"];
        key = "<C-s>";
        action = "<cmd>w<cr><esc>";
        desc = "Save";
      }
      {
        mode = ["i" "x" "n" "s"];
        key = "<C-A-S>";
        action = "<cmd>noau w<cr><esc>";
        desc = "Save without autocommand";
      }

      # view command histories
      {
        mode = "c";
        key = "<C-j>";
        action = "<Down>";
      }
      {
        mode = "c";
        key = "<C-k>";
        action = "<Up>";
      }

      # after yanking in visual mode, stay on cursor
      {
        mode = "v";
        key = "y";
        action = "ygv<Esc>";
      }

      # comments
      {
        mode = ["v" "n"];
        key = "<A-/>";
        action = "gcj";
        noremap = false;
      }
      {
        mode = "n";
        key = "<A-/>";
        action = "gccj";
        noremap = false;
      }
      {
        mode = "i";
        key = "<A-/>";
        action = "<Esc>gccji";
        noremap = false;
      }

      # duplicate line, comments old line, keep cursor position
      {
        mode = "v";
        key = "<A-S-/>";
        action = "<Esc>mzyygccp`z:delmarks z<cr>jV";
        noremap = false;
      }
      {
        mode = "n";
        key = "<A-S-/>";
        action = "mzyygccp`z:delmarks z<cr>j";
        noremap = false;
      }
      {
        mode = "i";
        key = "<A-S-/>";
        action = "<Esc>mzyygccp`z:delmarks z<cr>ja";
        noremap = false;
      }

      # select all, copy, paste
      {
        mode = "n";
        key = "<leader><C-a>";
        action = "ggVG";
        desc = "Selet all";
      }
      {
        mode = "n";
        key = "<C-c>";
        action = ''"+yy'';
        desc = "Copy to system clipboard";
      }
      {
        mode = "v";
        key = "<C-c>";
        action = ''"+ygv<Esc>'';
        desc = "Copy to system clipboard";
      }
      {
        mode = ["n" "v"];
        key = "<C-v>";
        action = ''"+p'';
        desc = "Paste from system clipboard";
      }
      {
        mode = "i";
        key = "<C-v>";
        action = ''<esc>"+pa'';
        desc = "Paste from system clipboard";
      }
      {
        mode = "c";
        key = "<C-v>";
        action = "<C-r>+";
        desc = "Paste from system clipboard";
      }

      # rebind v-block
      {
        mode = ["n" "v"];
        key = "<leader>v";
        action = "<C-v>";
        desc = "v-block";
      }

      # insert mode delete motion
      {
        mode = "i";
        key = "<C-l>";
        action = "<Del>";
        desc = "Delete a character after the cursor";
      }
      {
        mode = "i";
        key = "<C-w>";
        action = "<esc>ldwi";
        desc = "Delete a word after the cursor";
      }
      {
        mode = "i";
        key = "<C-d>";
        action = "<esc>ldbi";
        desc = "Delete a word before the cursor";
      }

      # change inner word
      {
        mode = "n";
        key = "<A-c>";
        action = "ciw";
        desc = "Change inner Word";
      }
      {
        mode = "n";
        key = "<A-C>";
        action = "ciW";
        desc = "Change inner WORD";
      }

      # select inner word
      {
        mode = "n";
        key = "<A-v>";
        action = "viw";
        desc = "Select inner Word";
      }
      {
        mode = "n";
        key = "<A-V>";
        action = "viW";
        desc = "Select inner WORD";
      }

      # delete line
      {
        mode = "n";
        key = "<A-x>";
        action = "dd";
        desc = "Delete line";
      }

      # quick navigate
      {
        mode = ["n" "v"];
        key = "H";
        action = "^";
        noremap = false;
      }
      {
        mode = ["n" "v"];
        key = "L";
        action = "$";
        noremap = false;
      }

      # center screeen after page up/down
      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
      }
      {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
      }

      # without this, <C-i> becomes <Tab>
      {
        mode = "n";
        key = "<C-i>";
        action = "<C-i>";
        desc = "Jump to newer position";
      }

      # search within visual selection
      {
        mode = "x";
        key = "/";
        action = "<Esc>/\\%V";
      }

      # open file explorer on root dir
      {
        mode = "n";
        key = "<leader>fo";
        action = ":!xdg-open .<cr>";
        desc = "Open File Explorer on Root Dir";
      }
      {
        mode = "n";
        key = "<leader>fO";
        action = ":!xdg-open %:p:h<cr>";
        desc = "Open File Explorer on Current Buffer";
      }

      # scroll up down faster
      {
        mode = "n";
        key = "<C-E>";
        action = "3<C-E>";
      }
      {
        mode = "n";
        key = "<C-Y>";
        action = "3<C-Y>";
      }

      # visual lines instead of logical lines on wrap
      {
        mode = ["n" "x"];
        key = "j";
        action = "v:count == 0 ? 'gj' : 'j'";
        desc = "Down";
        expr = true;
      }
      {
        mode = ["n" "x"];
        key = "<Down>";
        action = "v:count == 0 ? 'gj' : 'j'";
        desc = "Down";
        expr = true;
      }
      {
        mode = ["n" "x"];
        key = "k";
        action = "v:count == 0 ? 'gk' : 'k'";
        desc = "Up";
        expr = true;
      }
      {
        mode = ["n" "x"];
        key = "<Up>";
        action = "v:count == 0 ? 'gk' : 'k'";
        desc = "Up";
        expr = true;
      }

      # move lines
      {
        mode = "n";
        key = "<C-S-j>";
        action = "<cmd>execute 'move .+' . v:count1<cr>==";
        desc = "Move Down";
      }
      {
        mode = "n";
        key = "<C-S-k>";
        action = "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==";
        desc = "Move Up";
      }
      {
        mode = "i";
        key = "<C-S-j>";
        action = "<esc><cmd>m .+1<cr>==gi";
        desc = "Move Down";
      }
      {
        mode = "i";
        key = "<C-S-k>";
        action = "<esc><cmd>m .-2<cr>==gi";
        desc = "Move Up";
      }
      {
        mode = "v";
        key = "<C-S-j>";
        action = ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv";
        desc = "Move Down";
      }
      {
        mode = "v";
        key = "<C-S-k>";
        action = ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv";
        desc = "Move Up";
      }

      # clear search on escape
      {
        mode = ["i" "n" "s"];
        key = "<esc>";
        lua = true;
        expr = true;
        desc = "Escape and Clear hlsearch";
        action = ''
          function()
            vim.cmd("noh")
            return "<esc>"
          end
        '';
      }

      # -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
      {
        mode = "n";
        key = "n";
        action = "'Nn'[v:searchforward].'zv'";
        expr = true;
        desc = "Next Search Result";
      }
      {
        mode = "x";
        key = "n";
        action = "'Nn'[v:searchforward]";
        expr = true;
        desc = "Next Search Result";
      }
      {
        mode = "o";
        key = "n";
        action = "'Nn'[v:searchforward]";
        expr = true;
        desc = "Next Search Result";
      }
      {
        mode = "n";
        key = "N";
        action = "'nN'[v:searchforward].'zv'";
        expr = true;
        desc = "Prev Search Result";
      }
      {
        mode = "x";
        key = "N";
        action = "'nN'[v:searchforward]";
        expr = true;
        desc = "Prev Search Result";
      }
      {
        mode = "o";
        key = "N";
        action = "'nN'[v:searchforward]";
        expr = true;
        desc = "Prev Search Result";
      }

      # add undo break-points
      {
        mode = "i";
        key = ",";
        action = ",<c-g>u";
      }
      {
        mode = "i";
        key = ".";
        action = ".<c-g>u";
      }
      {
        mode = "i";
        key = ";";
        action = ";<c-g>u";
      }

      # keywordprg
      {
        mode = "n";
        key = "<leader>m";
        action = "<cmd>norm! K<cr>";
        desc = "Keywordprg";
      }

      # visual mode indentation keep the selection active
      {
        mode = "x";
        key = "<";
        action = "<gv";
      }
      {
        mode = "x";
        key = ">";
        action = ">gv";
      }
    ];
  };
}
