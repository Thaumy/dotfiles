{ config, ... }:
let
  homeDir = config.home.homeDirectory;
in
{
  programs.git = {
    enable = true;

    userName = "Thaumy Cheng";
    userEmail = "thaumy@outlook.com";
    signing = {
      signByDefault = true;
      key = "0x6A8A3AE9A7A59845"; # v3 [S]
    };

    lfs.enable = true;
    ignores = [ ".idea" ".vscode" ".thaumy" ];
    includes = [
      { path = "${homeDir}/cfg/git/config.ini"; }
      { path = "${homeDir}/cfg/git/aliases.ini"; }
    ];
  };
}
