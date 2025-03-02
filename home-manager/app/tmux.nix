{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file.".tmux.conf" = {
    enable = true;
    source = mkSymlink "${homeDir}/cfg/tmux/tmux.conf";
  };
}
