{ config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home = {
    packages = with pkgs; [
      alacritty
    ];
    file.".config/alacritty" = {
      enable = true;
      source = mkSymlink "${homeDir}/cfg/alacritty";
    };
  };
}
