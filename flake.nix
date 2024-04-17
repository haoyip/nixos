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
  };

  outputs = inputs @ { ... }:
    {
      nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };

        modules = [
          { nix.settings.experimental-features = [ "nix-command" "flakes" ]; }

          ./modules/hardware-configuration
          ./modules/configuration

          ./modules/flatpak
          ./modules/plasma
          ./modules/via
          ./modules/samba
          ./modules/corectrl

          # ./modules/gitlab-runner

          inputs.home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [ inputs.neovim-nightly-overlay.overlay ];

            home-manager.users.hao = import ./modules/home-manager;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
}
