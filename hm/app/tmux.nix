{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file.".config/tmux/tmux.conf".source = mkSymlink "${homeDir}/cfg/tmux/tmux.conf";
}
