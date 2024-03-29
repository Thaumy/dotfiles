{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file = {
    "dl" = {
      enable = true;
      source = mkSymlink "${homeDir}/Downloads";
    };
    "docs" = {
      enable = true;
      source = mkSymlink "${homeDir}/Documents";
    };
    "mus" = {
      enable = true;
      source = mkSymlink "${homeDir}/Music";
    };
    "pic" = {
      enable = true;
      source = mkSymlink "${homeDir}/Pictures";
    };
    "vid" = {
      enable = true;
      source = mkSymlink "${homeDir}/Videos";
    };
    "sec" = {
      enable = true;
      source = mkSymlink "${homeDir}/Documents/sec";
    };
  };
}
