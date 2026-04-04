{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  xdg.configFile."tmux/tmux.conf".source = mkSymlink "${homeDir}/cfg/tmux/tmux.conf";
}
