{ inputs, pkgs, ... }: {
  imports = [ inputs.hyprland.nixosModules.default ];

  programs.hyprland = {
    enable = true;
  };

  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
  ];
}
