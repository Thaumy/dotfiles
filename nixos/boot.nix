{ pkgs, config, ... }: {
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        devices = [ "nodev" ];
        efiSupport = true;
        extraEntries = ''
          menuentry "THE FUCKING WINDOWS" {
            insmod part_gpt
            insmod fat
            insmod search_fs_uuid
            insmod chain
            search --fs-uuid --set=root 2017-F7EE
            chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          }
        '';
        gfxmodeBios = "2560x1600";
        font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Bold.ttf";
        fontSize = 30;
      };
    };

    kernelPackages = pkgs.linuxPackages_cachyos;
    kernel.sysctl = { "vm.swappiness" = 20; };
    kernelModules = [
      "v4l2loopback"
    ];

    supportedFilesystems = [ "ntfs" ];

    extraModulePackages = with config.boot.kernelPackages;
      [ v4l2loopback.out ];
  };
}

