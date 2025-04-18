{ config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file.".config/mpv" = {
    enable = true;
    source = mkSymlink "${homeDir}/cfg/mpv";
  };
}
