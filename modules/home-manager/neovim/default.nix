{ pkgs, ... }:

{
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

      # language server
      docker-compose-language-service
      dockerfile-language-server-nodejs
      hadolint
      lua-language-server
      markdownlint-cli
      marksman
      nil
      nodePackages.typescript-language-server
      nodePackages.volar
      rust-analyzer
      tailwindcss-language-server
      taplo
      vscode-langservers-extracted
      yaml-language-server
    ];
  };

  xdg = {
    enable = true;

    configFile."nvim/init.lua".source = ./nvim/init.lua;
    configFile."nvim/lazyvim.json".source = ./nvim/lazyvim.json;
    configFile."nvim/lua".source = ./nvim/lua;
    configFile."nvim/leptosfmt.toml".source = ./nvim/leptosfmt.toml;
    configFile."nvim/stylua.toml".source = ./nvim/stylua.toml;
  };
}
