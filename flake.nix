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

    neovim = {
      url = "git+file:///home/hao/.vi";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    asus-fan = {
      url = "github:/ThatOneCalculator/asus-5606-fan-state";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {...}: let
    system = "x86_64-linux";

    pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [
        (final: prev: {
          # nixpkgs wraps anydesk with `--prefix GDK_BACKEND : x11`, which
          # yields `x11:wayland` when GDK_BACKEND is already set. GTK only
          # accepts comma-separated backends, so force `x11` outright.
          anydesk = prev.anydesk.overrideAttrs (old: {
            postFixup = ''
              patchelf \
                --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) \
                $out/bin/anydesk

              wrapProgram $out/bin/anydesk \
                --prefix PATH : ${
                prev.lib.makeBinPath [
                  prev.lsb-release
                  prev.pciutils
                ]
              } \
                --set GDK_BACKEND x11 \
                --suffix PATH : ${prev.lib.makeBinPath [prev.net-tools]} \
                --set GTK_THEME Adwaita --set GDK_SCALE 2 \
                --prefix LD_LIBRARY_PATH : ${prev.lib.makeLibraryPath old.buildInputs}
            '';
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
          username = "hao";
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
