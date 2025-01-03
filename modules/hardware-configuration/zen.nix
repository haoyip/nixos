{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "thunderbolt" "sdhci_pci"];
  boot.initrd.kernelModules = ["dm-snapshot"];
  boot.kernelModules = ["kvm-amd"];
  boot.kernelParams = ["amd_pstate=active" "amdgpu.dcdebugmask=0x600"];

  boot.initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/6dc0ebc8-644a-44e9-a164-b1248ea9eec2";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/48D9-7C92";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/064c47fa-13d4-47a8-a2e7-202710e5b100";
    fsType = "btrfs";
    options = ["subvol=@" "noatime" "compress=zstd:1"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/064c47fa-13d4-47a8-a2e7-202710e5b100";
    fsType = "btrfs";
    options = ["subvol=@home" "noatime" "compress=zstd:1"];
  };

  swapDevices = [
    {
      device = "/dev/disk/by-uuid/2b8781c2-27b4-466b-80cc-de500a2ecf8c";
    }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp198s0f4u1.useDHCP = lib.mkDefault true;

  networking.wireless.iwd = {
    enable = true;

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

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
}
