{
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };

  users.users.hao.extraGroups = [ "docker" ];
}
