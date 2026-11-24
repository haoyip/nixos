{...}: {
  imports = [
    ./autocmds.nix
    ./diagnostic.nix
    ./folding.nix
    ./keymaps.nix
    ./plugins
    ./tab.nix
    ./title.nix
    ./window.nix
  ];

  config.vim = {
    viAlias = false;
    vimAlias = false;
    enableLuaLoader = true;
    preventJunkFiles = false;
    vendoredKeymaps.enable = false;
    searchCase = "smart";
    lineNumberMode = "none";
    undoFile.enable = true;

    opts = {
      autowrite = true;
      backup = false;
      clipboard = "";
      completeopt = "menu,menuone,noselect";
      conceallevel = 2;
      confirm = true;
      cursorline = true;
      expandtab = true;
      formatoptions = "jcroqlnt";
      grepformat = "%f:%l:%c:%m";
      grepprg = "rg --vimgrep";
      ignorecase = true;
      inccommand = "nosplit";
      jumpoptions = "view";
      laststatus = 3;
      linebreak = true;
      list = true;
      mouse = "a";
      number = false;
      pumblend = 10;
      pumheight = 10;
      relativenumber = false;
      ruler = false;
      scrolloff = 4;
      sessionoptions = [
        "buffers"
        "curdir"
        "tabpages"
        "winsize"
        "help"
        "globals"
        "skiprtp"
        "folds"
      ];
      shiftround = true;
      shiftwidth = 2;
      shortmess = "TOcWClFIot";
      showmode = false;
      sidescrolloff = 8;
      signcolumn = "yes";
      smartcase = true;
      smartindent = true;
      smoothscroll = true;
      spelllang = ["en"];
      splitbelow = true;
      splitkeep = "screen";
      splitright = true;
      tabstop = 2;
      termguicolors = true;
      timeoutlen = 300;
      undofile = true;
      undolevels = 10000;
      updatetime = 200;
      virtualedit = "block";
      wildmode = "longest:full,full";
      winborder = "rounded";
      winminwidth = 5;
      wrap = false;
    };
  };
}
