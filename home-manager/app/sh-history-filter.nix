{ config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.packages = [ pkgs.nur.repos.thaumy.sh-history-filter ];
  home.file.".config/sh-history-filter" = {
    enable = true;
    source = mkSymlink "${homeDir}/cfg/sh-history-filter";
  };
}
