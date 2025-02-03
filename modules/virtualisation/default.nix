{pkgs, ...}: {
  virtualisation = {
    containers.enable = true;

    podman = {
      enable = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.systemPackages = with pkgs; [
    dive
    podman-compose
    podman-desktop
    podman-tui
  ];

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["hao"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}
