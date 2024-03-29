{ pkgs, config, ... }: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
      grub.configurationLimit = 4;
    };

    kernelPackages = pkgs.linuxPackages_6_7;
    kernel.sysctl = { "vm.swappiness" = 0; };
    kernelModules = [
      "v4l2loopback"
      # for VFIO
      "vfio_virqfd"
      "vfio_pci"
      "vfio_iommu_type1"
      "vfio"
    ];

    # for VFIO
    kernelParams = [ "amd_iommu=on" ];
    blacklistedKernelModules = [ "nvidia" "nouveau" ];
    extraModprobeConfig = "options vfio-pci ids=10de:2560,10de:228e";

    supportedFilesystems = [ "ntfs" ];

    extraModulePackages = with config.boot.kernelPackages;
      [ v4l2loopback.out ];
  };
}

