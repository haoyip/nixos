{lua, ...}: {
  config.vim = {
    autocomplete.blink-cmp = {
      enable = true;
      friendly-snippets.enable = true;

      mappings = {
        complete = null;
        confirm = null;
        next = null;
        previous = null;
        close = null;
        scrollDocsUp = null;
        scrollDocsDown = null;
      };

      setupOpts = {
        fuzzy.implementation = "prefer_rust_with_warning";
        signature.enabled = false;

        completion = {
          trigger = {
            show_on_insert = true;
            show_on_trigger_character = true;
            show_on_keyword = true;
            show_on_backspace = true;
          };
          list = {
            selection = {
              preselect = false;
              auto_insert = true;
            };
          };
          menu = {
            auto_show = true;
            border = "rounded";
            min_width = 35;
            auto_show_delay_ms = 100;
          };
        };

        keymap = {
          preset = "enter";

          "<C-e>" = ["scroll_documentation_down" "fallback"];
          "<C-y>" = ["scroll_documentation_up" "fallback"];

          "<A-j>" = [
            (lua "function(cmp) cmp.show() end")
            "select_next"
            "fallback"
          ];
          "<A-k>" = [
            (lua "function(cmp) cmp.show() end")
            "select_prev"
            "fallback"
          ];

          "<A-h>" = ["hide" "fallback"];
          "<A-l>" = ["select_and_accept" "fallback"];

          "<CR>" = [];

          "<A-i>" = [(lua ''function(cmp) cmp.show({ providers = { "lsp" } }) end'')];
          "<A-o>" = [(lua ''function(cmp) cmp.show({ providers = { "snippets" } }) end'')];
        };

        cmdline = {
          enabled = true;

          keymap = {
            preset = "none";

            "<A-j>" = [
              "select_next"
              (lua ''function(cmp) cmp.show({ providers = { "cmdline" } }) end'')
            ];
            "<A-k>" = [
              "select_prev"
              (lua ''function(cmp) cmp.show({ providers = { "cmdline" } }) end'')
            ];

            "<A-h>" = ["cancel"];
            "<A-l>" = ["accept"];

            "<Tab>" = [
              "select_next"
              (lua ''function(cmp) cmp.show({ providers = { "cmdline" } }) end'')
            ];
            "<S-Tab>" = [
              "select_prev"
              (lua ''function(cmp) cmp.show({ providers = { "cmdline" } }) end'')
            ];
          };
        };
      };
    };
  };
}
