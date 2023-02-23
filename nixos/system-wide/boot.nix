{ config, pkgs, ... }:

{

  boot = {

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";
    };

    kernelPackages = pkgs.linuxPackages_6_1;
    kernel.sysctl = { "vm.swappiness" = 30; };
    kernelModules = [ "v4l2loopback" ];

    supportedFilesystems = [ "ntfs" ];

    extraModulePackages = with config.boot.kernelPackages;
      [ v4l2loopback.out ];
  };

}
