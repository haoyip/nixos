{
  description = "Hao's NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mysecrets = {
      url = "git+ssh://git@gitlab/haoyiphoh/nixos-secrets.git?ref=main&shallow=1";
      flake = false;
    };

    zjstatus = {
      url = "github:dj95/zjstatus";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim = {
      url = "git+file:///home/hao/.vi";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {...}: let
    system = "x86_64-linux";

    pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [
        (final: prev: {
          zjstatus = inputs.zjstatus.packages.${prev.stdenv.hostPlatform.system}.default;

          # nixpkgs wraps anydesk with `--prefix GDK_BACKEND : x11`, which
          # yields `x11:wayland` when GDK_BACKEND is already set. GTK only
          # accepts comma-separated backends, so force `x11` outright.
          anydesk = prev.anydesk.overrideAttrs (old: {
            postFixup =
              builtins.replaceStrings
              [
                "--prefix GDK_BACKEND : x11"
                "--set GTK_THEME Adwaita"
              ]
              [
                "--set GDK_BACKEND x11"
                "--set GTK_THEME Adwaita --set GDK_SCALE 2"
              ]
              old.postFixup;
          });
        })
      ];

      config.allowUnfree = true;
    };

    buildSystem = modules:
      inputs.nixpkgs.lib.nixosSystem {
        inherit modules system pkgs;
        specialArgs = {
          inherit inputs;
          domain = "tingb.xyz";
        };
      };
  in {
    nixosConfigurations = {
      b450 = buildSystem [
        ./modules/nixos/common
        ./modules/nixos/hosts/b450
        ./modules/shell
      ];

      zen = buildSystem [
        ./modules/nixos/common
        ./modules/nixos/hosts/zen
        ./modules/shell
        ./modules/desktop
      ];
    };
  };
}
