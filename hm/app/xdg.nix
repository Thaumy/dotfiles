{ config, ... }:
let
  homeDir = config.home.homeDirectory;
in
{
  xdg.userDirs = {
    enable = true;
    music = "${homeDir}/mus";
    videos = "${homeDir}/vid";
    desktop = "${homeDir}/dt";
    download = "${homeDir}/dl";
    pictures = "${homeDir}/pic";
    documents = "${homeDir}/docs";
    templates = "${homeDir}/templates";
    publicShare = "${homeDir}/pub";
  };
}
