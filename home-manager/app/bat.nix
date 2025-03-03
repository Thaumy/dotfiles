{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file.".config/bat/config" = {
    enable = true;
    source = mkSymlink "${homeDir}/cfg/bat/config";
  };
}
