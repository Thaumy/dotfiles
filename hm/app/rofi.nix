{ config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.packages = [ pkgs.rofi ];
  xdg.configFile."rofi".source = mkSymlink "${homeDir}/cfg/rofi";
}
