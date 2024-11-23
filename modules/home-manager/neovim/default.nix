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

      # telescope-fzf-native
      cmake
      gnumake

      # language server
      docker-compose-language-service
      dockerfile-language-server-nodejs
      hadolint
      lua-language-server
      markdownlint-cli2
      marksman
      nixd
      phpactor
      rust-analyzer
      tabby-agent
      tailwindcss-language-server
      taplo
      vscode-langservers-extracted
      vtsls
      vue-language-server
      yaml-language-server

      # nodejs runtime for prettier to work
      nodejs
      nodePackages.prettier
    ];
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
  };
}
