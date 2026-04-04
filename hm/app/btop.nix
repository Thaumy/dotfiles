{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  xdg.configFile."btop".source = mkSymlink "${homeDir}/cfg/btop";
}
