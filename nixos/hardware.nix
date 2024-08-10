{ config, lib, ... }:
let
  enable_nvidia_vfio = false;
in
{
  hardware = {
    graphics.enable = true;
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    enableAllFirmware = true;
  };

  hardware.nvidia = lib.mkIf (!enable_nvidia_vfio) {
    open = true;
    nvidiaSettings = true;
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:6:0:0";
    };

    powerManagement = {
      # suspend/hibernate will fail if `enable = true;`
      # See: https://github.com/NixOS/nixpkgs/issues/254614
      enable = false;
      finegrained = true;
    };
  };

  boot = lib.mkIf enable_nvidia_vfio {
    kernelModules = [
      "vfio"
      "vfio_pci"
      "vfio_virqfd"
      "vfio_iommu_type1"
    ];
    kernelParams = [ "amd_iommu=on" ];
    blacklistedKernelModules = [ "nvidia" "nouveau" ];
    extraModprobeConfig = "options vfio-pci ids=10de:2560,10de:228e";
  };
}
