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
      hao-password = {};

      "private_keys/me_gitlab" = {
        path = "/home/hao/.ssh/me_gitlab";
        owner = "hao";
        mode = "400";
      };

      "private_keys/me_github" = {
        path = "/home/hao/.ssh/me_github";
        owner = "hao";
        mode = "400";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    sops
  ];
}
