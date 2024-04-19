{ config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home = {
    packages = with pkgs; [
      hypridle
      hyprlock
      hyprpaper
      hyprpicker
    ];
    file.".config/hypr" = {
      enable = true;
      source = mkSymlink "${homeDir}/cfg/hypr";
    };
  };
}
