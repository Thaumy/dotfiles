# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ lib, modulesPath, config, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd.availableKernelModules = [
      "nvme"
      "ahci"
      "sd_mod"
      "usbhid"
      "xhci_pci"
      "usb_storage"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/6baecf67-83a4-41a8-a666-c52ea7f17445";
      fsType = "btrfs";
      options = [ "subvol=@" ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/12acf6a4-b5cf-4682-99ce-2b68613bbe32";
      fsType = "btrfs";
      neededForBoot = true;
    };

    "/boot/efi" = {
      device = "/dev/disk/by-uuid/2017-F7EE";
      fsType = "vfat";
    };

    "/home" = {
      device = "/dev/disk/by-uuid/907a63da-8bdf-42db-af06-abb20596afd7";
      fsType = "btrfs";
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/d95517ad-0eb8-4254-b82c-4f85e4e485f4"; }
    { device = "/dev/disk/by-uuid/c26d843a-b1f5-4fcd-ae06-fd3630d1ee90"; }
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp4s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
