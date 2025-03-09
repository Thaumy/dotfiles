{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file.".config/btop" = {
    enable = true;
    source = mkSymlink "${homeDir}/cfg/btop";
  };
}
