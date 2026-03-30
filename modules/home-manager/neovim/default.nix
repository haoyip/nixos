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
      nil
      rust-analyzer
      tailwindcss-language-server
      tofu-ls
      vscode-langservers-extracted
      vtsls
      vue-language-server
      yaml-language-server
    ];
  };

  programs.neovide = {
    enable = true;

    settings = {};
  };

  xdg = {
    enable = true;

    configFile."nvim/init.lua".source = ./nvim/init.lua;
    configFile."nvim/lazyvim.json".source = ./nvim/lazyvim.json;
    configFile."nvim/lua".source = ./nvim/lua;
    configFile."nvim/stylua.toml".source = ./nvim/stylua.toml;
  };
}
