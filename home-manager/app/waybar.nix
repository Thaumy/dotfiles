{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  programs.waybar = {
    enable = true;
  };

  home.file.".config/waybar" = {
    enable = true;
    source = mkSymlink "${homeDir}/cfg/waybar";
  };
}
