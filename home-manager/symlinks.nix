{ config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file = {
    "sec" = {
      enable = true;
      source = mkSymlink "${homeDir}/docs/sec";
    };
    "org-repo" = {
      enable = true;
      source = mkSymlink "${homeDir}/dev/repo/org";
    };
    "thaumy-repo" = {
      enable = true;
      source = mkSymlink "${homeDir}/dev/repo/thaumy";
    };
    "lab" = {
      enable = true;
      source = mkSymlink "${homeDir}/dev/lab";
    };
  };
}
