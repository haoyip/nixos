{ pkgs, ... }:

{
  # This allow via to read keyboard
  services.udev.packages = with pkgs; [
    via
  ];

  environment.systemPackages = with pkgs; [
    via
  ];
}
