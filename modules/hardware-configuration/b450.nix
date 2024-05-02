{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware.enableRedistributableFirmware = true;

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.kernelParams = [ "amd_pstate=active" ];

  hardware.i2c.enable = true;

  # Allow user in 'i2c' group to use ddcutil without su
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8629-09A4";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/2e74f06d-f401-42bc-b2a4-5cfb00bcd777";
    fsType = "btrfs";
    options = [ "subvol=@" "noatime" "compress=zstd:1" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/2e74f06d-f401-42bc-b2a4-5cfb00bcd777";
    fsType = "btrfs";
    options = [ "subvol=@home" "noatime" "compress=zstd:1" ];
  };

  fileSystems."/media/8tb_1" = {
    device = "/dev/disk/by-label/8tb_1";
    fsType = "btrfs";
    options = [
      "noatime"
      "compress=zstd:3"

      "nofail" # Prevent system from failing if this drive doesn't mount
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/d543fe22-4619-4f40-bc12-9f86e3111e69"; }
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

    ddcutil
  ];
}
