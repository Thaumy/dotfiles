{ config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home = {
    packages = with pkgs; [
      rofi-wayland
    ];
    file.".config/rofi" = {
      enable = true;
      source = mkSymlink "${homeDir}/cfg/rofi";
    };
  };
}
