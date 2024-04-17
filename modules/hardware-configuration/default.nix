{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware.enableRedistributableFirmware = true;

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.supportedFilesystems = [ "btrfs" ];

  hardware.i2c.enable = true;

  # Allow user in 'i2c' group to use ddcutil without su
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/fbdbc338-e6f9-44da-955e-620a2cbdb852";
    fsType = "btrfs";
    options = [ "subvol=@" "noatime" "compress=zstd:1" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A77D-2BA5";
    fsType = "vfat";
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/73732a6e-e582-4e5e-9ff4-08031e5cc2d5"; }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp37s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.logitech.wireless.enable = true;

  environment.systemPackages = with pkgs; [
    solaar
    logitech-udev-rules
  ];
}
