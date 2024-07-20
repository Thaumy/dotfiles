{ pkgs, ... }: {
  services.xserver = {
    enable = true;

    xkb.layout = "us";
    xkb.variant = "";

    displayManager.gdm = {
      enable = true;
      autoSuspend = false;
    };

    dpi = 180;
    videoDrivers = [ "nvidia" ];
    excludePackages = [ pkgs.xterm ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
