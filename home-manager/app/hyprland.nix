{ inputs, pkgs, ... }:
{
  imports = [ inputs.hyprland.homeManagerModules.default ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    extraConfig = "source = ~/cfg/hypr/hyprland/hyprland.conf";
  };

  home = {
    packages = with pkgs; [
      hypridle
      hyprlock
      hyprshot
      hyprpaper
      hyprpicker
    ];
  };
}
