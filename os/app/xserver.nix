{ pkgs, ... }: {
  services.xserver = {
    enable = true;

    xkb.layout = "us";
    xkb.variant = "";

    dpi = 180;
    videoDrivers = [ "nvidia" ];
    excludePackages = [ pkgs.xterm ];
  };
}
