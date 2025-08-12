{ pkgs, ... }: {
  documentation.dev.enable = true;
  environment.systemPackages = with pkgs; [
    man-pages
    linux-manual
    man-pages-posix
  ];
}
