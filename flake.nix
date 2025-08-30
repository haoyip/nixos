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
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bacon-ls = {
      url = "github:crisidev/bacon-ls";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {...}: let
    system = "x86_64-linux";

    pkgs = import inputs.nixpkgs {
      inherit system;
      overlays = [
        (final: prev: {
          zjstatus = inputs.zjstatus.packages.${prev.system}.default;
        })

        inputs.bacon-ls.overlay.${system}
      ];

      config.allowUnfree = true;
    };

    specialArgs = {inherit inputs;};

    commonModules = [
      {nix.settings.experimental-features = ["nix-command" "flakes"];}
      {programs.nix-ld.enable = true;}

      ./modules/configuration/common.nix
      ./modules/plasma
      ./modules/firewall
      ./modules/scripts
      ./modules/maintenance

      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.users.hao = import ./modules/home-manager;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {inherit inputs pkgs system;};
      }
    ];

    buildConfig = modules: {
      inherit modules system pkgs specialArgs;
    };

    buildSystem = modules: inputs.nixpkgs.lib.nixosSystem (buildConfig (modules ++ commonModules));
  in {
    nixosConfigurations = {
      b450 = buildSystem [
        ./modules/hardware-configuration/b450.nix
        ./modules/configuration/b450.nix
        ./modules/wireguard/b450.nix

        ./modules/samba
        ./modules/corectrl
        ./modules/virtualisation
        # ./modules/gitlab-runner
        ./modules/update-ddns
        ./modules/odbc

        ./modules/sops
        ./modules/ssh/b450.nix
        ./modules/ssh/openssh.nix
      ];

      zen = buildSystem [
        ./modules/hardware-configuration/zen.nix
        ./modules/configuration/zen.nix
        ./modules/scripts/zen-fan.nix
        ./modules/scripts/zen-wifi.nix
        ./modules/scripts/zen-vpn.nix

        ./modules/virtualisation
        ./modules/odbc

        ./modules/sops
        ./modules/ssh/zen.nix
        ./modules/wireguard/zen.nix
      ];

      mate = buildSystem [
        ./modules/hardware-configuration/mate.nix
        ./modules/configuration/mate.nix
        ./modules/wireguard/mate.nix
      ];
    };
  };
}
