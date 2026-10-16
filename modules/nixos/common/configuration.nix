{
  inputs,
  pkgs,
  ...
}: let
  hasIPv6Internet = true;
  StateDirectory = "dnscrypt-proxy";
in {
  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "25.11";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  services.fwupd.enable = true;

  networking = {
    nameservers = ["127.0.0.1" "::1"];
    networkmanager.dns = "none";
  };

  # See https://wiki.nixos.org/wiki/Encrypted_DNS
  services.dnscrypt-proxy = {
    enable = true;
    # See https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml
    settings = {
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3"; # See https://github.com/DNSCrypt/dnscrypt-resolvers/blob/master/v3/public-resolvers.md
        cache_file = "/var/lib/${StateDirectory}/public-resolvers.md";
      };

      # Use servers reachable over IPv6 -- Do not enable if you don't have IPv6 connectivity
      ipv6_servers = hasIPv6Internet;
      block_ipv6 = ! (hasIPv6Internet);

      require_dnssec = true;
      require_nolog = true;
      require_nofilter = true;
    };
  };

  systemd.services.dnscrypt-proxy.serviceConfig.StateDirectory = StateDirectory;

  time.timeZone = "Asia/Kuala_Lumpur";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.hao = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "hao";
    extraGroups = [
      "wheel"
      "i2c"
      "networkmanager"
    ];
  };

  programs.fish.enable = true;

  environment.sessionVariables = {
    # Hint electron apps to use wayland:
    NIXOS_OZONE_WL = "1";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    package = inputs.neovim.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  environment.variables = {
    EDITOR = "nvim";
  };

  i18n.defaultLocale = "en_US.UTF-8";

  programs.nix-ld.enable = true;
}
