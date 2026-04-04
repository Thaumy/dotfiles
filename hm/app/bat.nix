{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  xdg.configFile."bat/config".source = mkSymlink "${homeDir}/cfg/bat/config";
}
