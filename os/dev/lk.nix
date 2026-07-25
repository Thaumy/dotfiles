{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    flex
    bison
    gcc15
    pahole
    ncurses
    gnumake
    linux-scripts
    universal-ctags
    config.boot.kernelPackages.perf
  ];
}
