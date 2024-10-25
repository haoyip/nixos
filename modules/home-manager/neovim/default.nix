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
      nodePackages.typescript-language-server
      rust-analyzer
      tailwindcss-language-server
      taplo
      vscode-langservers-extracted
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
  };
}
