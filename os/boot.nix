{ pkgs, config, lib, ... }:
let
  buildKernel = attrs: lib.recurseIntoAttrs (
    pkgs.linuxPackagesFor (pkgs.linuxKernel.manualConfig (attrs // (
      let
        stdenv = pkgs.ccacheStdenv;
      in
      {
        inherit stdenv;
      }
    )))
  );
in
{
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

    kernelPackages = buildKernel {
      version = "7.0.9";
      src = pkgs.fetchgit {
        url = "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git";
        tag = "v7.0.9";
        hash = "sha256-eSU5Ww3RuaZOC5m6KQ7AiW/VnHTkoQKu8cB9n9mcHYY=";
      };
      configfile = ./config;
    };

    kernelParams = [ "nohz_full=1-15" ];

    kernel.sysctl = {
      "vm.swappiness" = 20;
      "kernel.perf_event_paranoid" = -1;
      "kernel.perf_event_max_sample_rate" = 10000;
    };

    supportedFilesystems = [ "ntfs" ];

    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  };
}
