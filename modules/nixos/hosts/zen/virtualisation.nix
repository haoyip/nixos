{pkgs, username, ...}: {
  virtualisation = {
    containers.enable = true;

    podman = {
      enable = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };

    spiceUSBRedirection.enable = true;

    libvirtd = {
      enable = true;

      qemu.vhostUserPackages = [pkgs.virtiofsd];
    };
  };

  environment.systemPackages = with pkgs; [
    dive
    podman-compose
    podman-tui
  ];

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [username];
}
