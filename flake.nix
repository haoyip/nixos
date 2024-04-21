{
  description = "Hao's NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    flatpaks.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { ... }:
    let
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };

      commonModules = [
        { nix.settings.experimental-features = [ "nix-command" "flakes" ]; }

        ./modules/configuration/common.nix
        ./modules/plasma
        ./modules/firewall

        inputs.home-manager.nixosModules.home-manager
        {
          nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlay ];

          home-manager.users.hao = import ./modules/home-manager;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];

      buildConfig = modules: {
        inherit modules system specialArgs;
      };

      buildSystem = modules: inputs.nixpkgs.lib.nixosSystem (buildConfig (modules ++ commonModules));
    in
    {
      nixosConfigurations = {
        b450 = buildSystem [
          ./modules/hardware-configuration/b450.nix
          ./modules/configuration/b450.nix

          ./modules/via
          ./modules/samba
          ./modules/corectrl
          ./modules/gitlab-runner
          ./modules/flatpak

          ./modules/sops
          inputs.sops-nix.nixosModules.sops
        ];

        mate = buildSystem [
          ./modules/hardware-configuration/mate.nix
          ./modules/configuration/mate.nix
        ];
      };
    };
}
