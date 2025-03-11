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

  boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/08c779b2-1244-4a9c-a21f-2bbb568f3e34";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/3363-D424";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/9a07ea48-ceca-4825-8fa8-855e673f48da";
    fsType = "btrfs";
    options = ["subvol=@" "noatime" "compress=zstd:1"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/9a07ea48-ceca-4825-8fa8-855e673f48da";
    fsType = "btrfs";
    options = ["subvol=@home" "noatime" "compress=zstd:1"];
  };

  fileSystems."/data/8tb_1" = {
    device = "/dev/disk/by-uuid/9fc6b93d-2949-4df3-bcd4-daf36d233a69";
    fsType = "btrfs";
    options = [
      "noatime"
      "compress=zstd:3"

      "nofail" # Prevent system from failing if this drive doesn't mount
    ];
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/452fe62c-b40e-4d49-814e-007394dc8b13";
    }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp37s0.useDHCP = lib.mkDefault true;

  networking.wireless.iwd = {
    enable = false;

    settings = {
      IPv6 = {
        Enabled = true;
      };
      Settings = {
        AutoConnect = false;
      };
      General = {
        EnableNetworkConfiguration = true;
      };
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  environment.systemPackages = with pkgs; [
    ddcutil
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  networking.interfaces.enp37s0.wakeOnLan.enable = true;
}
