{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}: let
  # https://wiki.archlinux.org/title/ASUS_Zenbook_UM5606
  edid = pkgs.runCommand "edid-firmware" {} ''
    install -Dm644 ${./edid_mclk_fix.bin} \
      $out/lib/firmware/edid/edid_mclk_fix.bin
  '';
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  hardware.firmware = [edid];

  boot.initrd.extraFiles = {
    "lib/firmware/edid/edid_mclk_fix.bin" = "${edid}/lib/firmware/edid/edid_mclk_fix.bin";
  };

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "thunderbolt" "sdhci_pci"];
  boot.initrd.kernelModules = ["dm-snapshot"];
  boot.kernelModules = ["kvm-amd"];
  boot.kernelParams = [
    "amd_pstate=active"

    "zswap.enabled=1"
    "zswap.compressor=zstd"
    "zswap.max_pool_percent=20"
    "zswap.shrinker_enabled=1"

    "drm.edid_firmware=eDP-1:edid/edid_mclk_fix.bin"
  ];

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

  networking.networkmanager.enable = true;

  systemd.services.NetworkManager-wait-online.enable = false;

  # Disable NetworkManager's internal DNS resolution
  networking.networkmanager.dns = "none";

  # These options are unnecessary when managing DNS ourselves
  networking.useDHCP = false;
  networking.dhcpcd.enable = false;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.i2c.enable = true;

  # Allow user in 'i2c' group to use ddcutil without su
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  environment.systemPackages = with pkgs; [
    ddcutil
  ];
}
