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

    kernelPackages = (pkgs.callPackage
      (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/c14d6c992b7e1709a62b93f10a242b04737b66f1.tar.gz";
        sha256 = "11325lp5krlhk62nvr1nriaah1y07wvm42dglzw0nicv8dpr70a7";
      })
      { }
    ).linuxPackages_6_12;

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
