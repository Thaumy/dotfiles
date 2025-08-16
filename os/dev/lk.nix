{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    flex
    bison
    gcc14
    gnumake
    linux-scripts
    universal-ctags
    config.boot.kernelPackages.perf
  ];
}
