{ pkgs, ... }: {
  services.xserver = {
    enable = true;

    xkb.layout = "us";
    xkb.variant = "";

    dpi = 180;
    videoDrivers = [ "nvidia" ];
    excludePackages = [ pkgs.xterm ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
