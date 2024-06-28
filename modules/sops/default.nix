{
  inputs,
  pkgs,
  ...
}: let
  secretspath = builtins.toString inputs.mysecrets;
in {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;

    age.keyFile = "/home/hao/.config/sops/age/keys.txt";

    secrets = {
      gitlab-runner-docker-token = {};
    };
  };

  environment.systemPackages = with pkgs; [
    sops
  ];
}
