{ pkgs, ... }:

{
  virtualisation = {
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };

  users.users.hao.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    dive
  ];
}
