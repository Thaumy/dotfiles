{ config, ... }:
let
  nvidia_vfio = false;
in
{
  hardware = {
    enableAllFirmware = true;
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    graphics.enable = true;
  };

  hardware.nvidia =
    if !nvidia_vfio then {
      open = true;
      nvidiaSettings = true;
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        nvidiaBusId = "PCI:0:1:0";
        amdgpuBusId = "PCI:0:6:0";
      };

      powerManagement = {
        # suspend/hibernate will fail if `enable = true;`
        # See: https://github.com/NixOS/nixpkgs/issues/254614
        enable = false;
        finegrained = true;
      };
    } else { };


  boot =
    if nvidia_vfio then {
      kernelModules = [
        "vfio_virqfd"
        "vfio_pci"
        "vfio_iommu_type1"
        "vfio"
      ];
      kernelParams = [ "amd_iommu=on" ];
      blacklistedKernelModules = [ "nvidia" "nouveau" ];
      extraModprobeConfig = "options vfio-pci ids=10de:2560,10de:228e";
    } else { };
}
