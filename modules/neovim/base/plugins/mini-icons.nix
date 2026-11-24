{lib, ...}: {
  config.vim = {
    mini.icons.enable = true;

    # Compatibility layer for plugins expecting nvim-web-devicons
    luaConfigRC = {
      mini-icons-mock = lib.nvim.dag.entryAfter ["pluginConfigs"] ''
        require("mini.icons").mock_nvim_web_devicons()
      '';
    };
  };
}
