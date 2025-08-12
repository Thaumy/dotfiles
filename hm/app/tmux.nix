{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file.".tmux.conf".source = mkSymlink "${homeDir}/cfg/tmux/tmux.conf";
}
