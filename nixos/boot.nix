{ pkgs, config, ... }: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
      grub.configurationLimit = 4;
    };

    kernelPackages = pkgs.linuxPackages_6_9;
    kernel.sysctl = { "vm.swappiness" = 0; };
    kernelModules = [
      "v4l2loopback"
    ];

    supportedFilesystems = [ "ntfs" ];

    extraModulePackages = with config.boot.kernelPackages;
      [ v4l2loopback.out ];
  };
}

