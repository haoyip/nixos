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

  # boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/08c779b2-1244-4a9c-a21f-2bbb568f3e34";
  # boot.initrd.luks.devices."8tb_1".device = "/dev/disk/by-uuid/8bf54ff6-bd1c-4669-af77-52aee73283f0";

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

  # fileSystems."/data/8tb_1" = {
  #   device = "/dev/disk/by-uuid/f8dbcefa-e211-4248-a59c-952510ed926a";
  #   fsType = "btrfs";
  #   options = [
  #     "noatime"
  #     "compress=zstd:3"
  #
  #     "nofail" # Prevent system from failing if this drive doesn't mount
  #   ];
  # };

  fileSystems."/data/8tb_2" = {
    device = "/dev/disk/by-uuid/b833828d-9e25-4318-b550-df10d40a6cf2";
    fsType = "ext4";
    options = [
      "noatime"

      "nofail" # Prevent system from failing if this drive doesn't mount
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  environment.systemPackages = with pkgs; [
    cryptsetup
    ddcutil
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  networking.interfaces.enp37s0.wakeOnLan.enable = true;
}
