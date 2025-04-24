{ pkgs, config, ... }: {
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
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
            search --fs-uuid --set=root DB21-C5AF
            chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          }
        '';
        gfxmodeBios = "2560x1600";
        font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Bold.ttf";
        fontSize = 30;
      };
    };

    kernelPackages = pkgs.linuxPackages_6_14;
    kernel.sysctl = {
      "vm.swappiness" = 20;
      "kernel.perf_event_paranoid" = -1;
      "kernel.perf_event_max_sample_rate" = 10000;
    };
    kernelModules = [
      "v4l2loopback"
    ];

    supportedFilesystems = [ "ntfs" ];

    extraModulePackages = with config.boot.kernelPackages;
      [ v4l2loopback.out ];
  };
}

