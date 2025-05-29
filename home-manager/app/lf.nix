{ config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.packages = [ pkgs.lf ];
  home.file.".config/lf".source = mkSymlink "${homeDir}/cfg/lf";
}
