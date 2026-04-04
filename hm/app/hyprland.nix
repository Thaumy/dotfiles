{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  xdg.configFile = {
    "hypr/hyprland.conf".source = mkSymlink "${homeDir}/cfg/hypr/hyprland/hyprland.conf";
    "hypr/hyprpaper.conf".source = mkSymlink "${homeDir}/cfg/hypr/hyprpaper/hyprpaper.conf";
  };
}
