{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      source ${homeDir}/cfg/fish/interactive.fish
    '';
  };

  home.file.".config/fish/functions".source = mkSymlink "${homeDir}/cfg/fish/functions";
}
