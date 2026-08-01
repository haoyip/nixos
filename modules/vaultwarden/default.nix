{lib, ...}: {
  services.vaultwarden = {
    enable = true;
    backupDir = "/data/8tb_1/vaultwarden-backup";
    environmentFile = "/data/8tb_1/vaultwarden/vaultwarden.env";

    config = {
      # Refer to https://github.com/dani-garcia/vaultwarden/blob/main/.env.template
      SIGNUPS_ALLOWED = false;

      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
      ROCKET_LOG = "critical";

      DATA_FOLDER = "/data/8tb_1/vaultwarden";

      # This example assumes a mailserver running on localhost,
      # thus without transport encryption.
      # If you use an external mail server, follow:
      #   https://github.com/dani-garcia/vaultwarden/wiki/SMTP-configuration
      # SMTP_HOST = "127.0.0.1";
      # SMTP_PORT = 25;
      # SMTP_SECURITY = off;
      #
      # SMTP_FROM = "admin@bitwarden.example.com";
      # SMTP_FROM_NAME = "example.com Bitwarden server";
    };
  };

  systemd.services.vaultwarden.serviceConfig.ReadWritePaths = [
    "/data/8tb_1/vaultwarden"
  ];

  systemd.services.vaultwarden = {
    wantedBy = lib.mkForce [];
  };
}
