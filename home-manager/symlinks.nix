{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file = {
    "sec" = {
      enable = true;
      source = mkSymlink "${homeDir}/docs/sec";
    };
  };
}
