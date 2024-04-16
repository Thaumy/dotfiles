{ config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home = {
    packages = with pkgs; [
      nur.repos.thaumy.sh-history-filter
    ];
    file.".config/sh-history-filter" = {
      enable = true;
      source = mkSymlink "${homeDir}/cfg/sh-history-filter";
    };
  };
}
