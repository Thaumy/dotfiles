{ pkgs, config, lib, ... }:
let
  buildKernel = attrs: lib.recurseIntoAttrs (
    pkgs.linuxPackagesFor (pkgs.buildLinux (attrs // (
      let
        stdenv = pkgs.ccacheStdenv;
      in
      {
        inherit stdenv;
        buildPackages = pkgs.buildPackages // { inherit stdenv; };
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
      version = "6.19";
      src = pkgs.fetchgit {
        url = "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git";
        tag = "v6.19";
        hash = "sha256-Mq1NVGL7Y7NtEEPdVvskGhG6CeIscTA6YYXdwtEqFG0=";
      };
      structuredExtraConfig = with lib.kernel; {
        # See: https://github.com/NixOS/nixpkgs/commit/6b6c8b140268f092e1fbc66fe7b6d122009ac3cb
        RUST_FW_LOADER_ABSTRACTIONS = yes;
      };
    };

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
