{
  pkgs,
  username,
  ...
}: {
  virtualisation = {
    containers.enable = true;

    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    spiceUSBRedirection.enable = true;

    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = [pkgs.virtiofsd];
    };
  };

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [username];
}
