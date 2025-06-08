{ config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  home.file = {
    "lab".source = mkSymlink "${homeDir}/dev/lab";
    "sec".source = mkSymlink "${homeDir}/docs/sec";
    "org-repo".source = mkSymlink "${homeDir}/dev/repo/org";
    "fork-repo".source = mkSymlink "${homeDir}/dev/repo/fork";
    "thaumy-repo".source = mkSymlink "${homeDir}/dev/repo/thaumy";

    ".config/nixpkgs/config.nix" = {
      source = pkgs.writeTextFile {
        name = "config.nix";
        text = "{ allowUnfree = true; }";
      };
      recursive = true;
    };
  };
}
