{ inputs, pkgs, ... }:
{
  imports = [ inputs.hyprland.homeManagerModules.default ];

  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [
      pkgs.hyprlandPlugins.hyprfocus
    ];

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
