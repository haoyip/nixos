{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware.enableRedistributableFirmware = true;

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  boot.kernelModules = ["kvm-amd"];
  boot.kernelParams = ["amd_pstate=active"];

  hardware.i2c.enable = true;

  # Allow user in 'i2c' group to use ddcutil without su
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5e7160b7-924d-4752-988e-8d52dd7ecdd6";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/AE99-7554";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/10e5e802-6eb0-48f0-9928-de2dcc8a22eb";}
  ];

  fileSystems."/data/8tb_1" = {
    device = "/dev/disk/by-uuid/f8dbcefa-e211-4248-a59c-952510ed926a";
    fsType = "btrfs";
    options = [
      "noatime"
      "compress=zstd:3"

      # unlock after boot
      "noauto"
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  environment.systemPackages = with pkgs; [
    btrfs-progs
    cryptsetup
    ddcutil
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  networking.interfaces.enp37s0.wakeOnLan.enable = true;
}
