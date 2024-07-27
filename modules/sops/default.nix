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
    age.keyFile = "/sops/keys.txt";

    defaultSopsFile = "${secretspath}/secrets.yaml";
    validateSopsFiles = false;
  };

  environment.systemPackages = with pkgs; [
    sops
  ];
}
