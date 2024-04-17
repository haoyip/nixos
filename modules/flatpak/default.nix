{ inputs, ... }:

{
  imports = [
    inputs.flatpaks.nixosModules.nix-flatpak
  ];

  services.flatpak = {
    enable = true;
    packages = [
      "com.todoist.Todoist"
      "com.spotify.Client"
      "org.qbittorrent.qBittorrent"
      "com.valvesoftware.Steam"
      "net.ankiweb.Anki"
      "com.discordapp.Discord"
    ];
  };
}
