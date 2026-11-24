{lua, ...}: {
  config.vim.mini = {
    ai = {
      enable = true;
      setupOpts = lua ''
        {
          n_lines = 500,
          custom_textobjects = {
            -- tags
            t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },

            -- digits
            d = { "%f[%d]%d+" },

            -- word with case
            e = {
              { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[^%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
              "^().*()$",
            },

            -- u for usage
            u = require("mini.ai").gen_spec.function_call(),

            -- without dot in function name
            U = require("mini.ai").gen_spec.function_call({ name_pattern = "[%w_]" }),

            -- code block
            o = require("mini.ai").gen_spec.treesitter({
              a = { "@block.outer", "@conditional.outer", "@loop.outer" },
              i = { "@block.inner", "@conditional.inner", "@loop.inner" },
            }),

            -- function
            f = require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),

            -- class
            c = require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
          },
        }
      '';
    };
  };
}
