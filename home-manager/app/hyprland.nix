{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file = {
    ".config/hypr/hyprland.conf".source = mkSymlink "${homeDir}/cfg/hypr/hyprland/hyprland.conf";
    ".config/hypr/hyprpaper.conf".source = mkSymlink "${homeDir}/cfg/hypr/hyprpaper/hyprpaper.conf";
  };
}
