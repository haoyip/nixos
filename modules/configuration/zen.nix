{pkgs, ...}: {
  networking.hostName = "zen";

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_6_12;
  };
}
