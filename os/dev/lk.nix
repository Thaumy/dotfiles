{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    flex
    bison
    gcc14
    gnumake
    universal-ctags
    config.boot.kernelPackages.perf
  ];
}
