{ config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.packages = [ pkgs.nur.repos.thaumy.dup-img-finder ];
  home.file.".config/dup-img-finder" = {
    enable = true;
    source = mkSymlink "${homeDir}/cfg/dup-img-finder";
  };
}
