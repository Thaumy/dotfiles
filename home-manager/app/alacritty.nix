{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file.".config/alacritty/alacritty.toml".source = mkSymlink "${homeDir}/cfg/alacritty/config.toml";
}
