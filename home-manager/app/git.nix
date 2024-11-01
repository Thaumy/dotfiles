{ config, ... }:
let
  homeDir = config.home.homeDirectory;
in
{
  programs.git = {
    enable = true;

    userName = "Thaumy";
    userEmail = "thaumy@outlook.com";
    signing = {
      signByDefault = true;
      #key = "9371 D49E 5DDF 58CC 9E8A  6CDD 8459 7965 A0D4 17A8"; # V1
      key = "B219 D68E 1BD0 6B0A 1412  642F 0A28 E9D2 941B B233"; # V2
    };

    lfs.enable = true;
    ignores = [ ".idea" ".vscode" ".thaumy" ];
    includes = [
      { path = "${homeDir}/cfg/git/config.ini"; }
      { path = "${homeDir}/cfg/git/aliases.ini"; }
    ];
  };
}
