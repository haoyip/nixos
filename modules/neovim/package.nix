{
  inputs,
  pkgs,
}: let
  buildPlugin = {
    name,
    src,
  }:
    pkgs.vimUtils.buildVimPlugin {
      pname = name;
      inherit src;
      version = toString (src.lastModifiedDate or "unstable");
      postInstall = ''
        rm -f "$out/deps"
      '';
    };

  diffbanditPlugin = buildPlugin {
    name = "diffbandit";
    src = inputs.diffbandit;
  };

  mkNeovim = modules:
    (inputs.nvf.lib.neovimConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        inherit diffbanditPlugin;
      };

      modules =
        [
          {
            _module.args = {
              lua = inputs.nixpkgs.lib.generators.mkLuaInline;
            };
          }
        ]
        ++ modules;
    }).neovim;
in {
  default = mkNeovim [
    ./base
  ];

  full = mkNeovim [
    ./base
    ./full
  ];
}
