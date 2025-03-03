{ pkgs, ... }: {
  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [
          "gtk"
        ];
      };
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      xdg-desktop-portal-hyprland
      kdePackages.xdg-desktop-portal-kde
    ];
  };
}
