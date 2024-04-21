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

      buildConfig = modules: { inherit modules system specialArgs; };
      buildSystem = modules: inputs.nixpkgs.lib.nixosSystem (buildConfig modules);
    in
    {
      nixosConfigurations = {
        b450 = buildSystem [
          { nix.settings.experimental-features = [ "nix-command" "flakes" ]; }

          ./modules/sops

          ./modules/hardware-configuration/default.nix
          ./modules/configuration

          ./modules/flatpak
          ./modules/plasma
          ./modules/via
          ./modules/samba
          ./modules/corectrl
          ./modules/firewall
          ./modules/gitlab-runner

          inputs.sops-nix.nixosModules.sops

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
