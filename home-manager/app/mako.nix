{ config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home = {
    packages = with pkgs; [
      mako
      libnotify
    ];
    file.".config/mako" = {
      enable = true;
      source = mkSymlink "${homeDir}/cfg/mako";
    };
  };
}
