{pkgs, ...}: {
  networking.hostName = "b450";

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_6_13;
  };
}
