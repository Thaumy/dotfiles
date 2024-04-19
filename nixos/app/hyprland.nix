{ pkgs, ... }: {
  programs.hyprland = {
    enable = true;
  };

  services.gvfs.enable = true;

  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
  ];
}
