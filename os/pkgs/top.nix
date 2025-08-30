{ pkgs, ... }: with pkgs; [
  dool
  iotop
  bandwhich
  nvtopPackages.full
  (btop.override { cudaSupport = true; rocmSupport = true; })
]
