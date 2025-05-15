{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file.".config/hypr/hyprland.conf" = {
    enable = true;
    source = mkSymlink "${homeDir}/cfg/hypr/hyprland/hyprland.conf";
  };
}
