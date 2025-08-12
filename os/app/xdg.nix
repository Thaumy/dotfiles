{ pkgs, ... }: {
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      xdg-desktop-portal-hyprland
      kdePackages.xdg-desktop-portal-kde
    ];
  };
}
