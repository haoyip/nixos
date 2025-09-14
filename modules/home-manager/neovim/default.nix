{
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      # treesitter build tools
      gcc

      # language server
      bacon-ls
      docker-compose-language-service
      dockerfile-language-server
      hadolint
      lua-language-server
      markdownlint-cli2
      marksman
      nixd
      rust-analyzer
      tailwindcss-language-server
      taplo
      tofu-ls
      vscode-langservers-extracted
      vtsls
      vue-language-server
      yaml-language-server

      # nodejs runtime for prettier to work
      nodejs
      nodePackages.prettier
    ];
  };

  programs.neovide = {
    enable = true;

    settings = {};
  };

  # for nixd
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  xdg = {
    enable = true;

    configFile."nvim/init.lua".source = ./nvim/init.lua;
    configFile."nvim/lazyvim.json".source = ./nvim/lazyvim.json;
    configFile."nvim/lua".source = ./nvim/lua;
    configFile."nvim/stylua.toml".source = ./nvim/stylua.toml;

    configFile."nvim/after/queries/blade/highlights.scm".source = ./blade/highlights.scm;
    configFile."nvim/after/queries/blade/injections.scm".source = ./blade/injections.scm;
    configFile."nvim/after/queries/html/injections.scm".source = ./html/injections.scm;
  };
}
