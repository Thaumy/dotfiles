{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file.".config/mpv".source = mkSymlink "${homeDir}/cfg/mpv";
}
