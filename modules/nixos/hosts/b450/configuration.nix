{
  inputs,
  pkgs,
  domain,
  ...
}: {
  networking.hostName = "b450";

  networking.firewall.interfaces.wg0 = {
    allowedUDPPorts = [53];
    allowedTCPPorts = [53];
  };

  services.dnsmasq = {
    enable = true;

    settings = {
      interface = "wg0";
      bind-interfaces = true;

      address = [
        "/pic.${domain}/10.0.0.1"
        "/tv.${domain}/10.0.0.1"
        "/drive.${domain}/10.0.0.1"
        "/mail.${domain}/10.0.0.1"
        "/vault.${domain}/10.0.0.1"
      ];

      # Forward everything else to dnscrypt-proxy
      server = [
        "127.0.0.1#5300"
      ];
    };
  };

  services.dnscrypt-proxy.settings.listen_addresses = [
    "127.0.0.1:5300"
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    package = inputs.neovim.packages.${pkgs.stdenv.hostPlatform.system}.light;
  };
}
