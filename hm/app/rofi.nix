{ config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.packages = [ pkgs.rofi-wayland ];
  home.file.".config/rofi".source = mkSymlink "${homeDir}/cfg/rofi";
}
