{pkgs, ...}: {
  sops.defaultSopsFile = ./secrets.yaml;

  sops.age.keyFile = "/home/hao/.config/sops/age/keys.txt";

  sops.secrets.gitlab-runner-docker-token = {};

  environment.systemPackages = with pkgs; [
    sops
  ];
}
