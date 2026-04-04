{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  programs.waybar = {
    enable = true;
  };

  xdg.configFile."waybar".source = mkSymlink "${homeDir}/cfg/waybar";
}
