{config, username, ...}: {
  sops.secrets = {
    "authorized_keys/b450/zen" = {
      owner = username;
    };
  };

  services.openssh = {
    enable = true;
    ports = [22];
    openFirewall = true;

    authorizedKeysInHomedir = false;
    authorizedKeysFiles = [
      "${config.sops.secrets."authorized_keys/b450/zen".path}"
    ];

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
}
