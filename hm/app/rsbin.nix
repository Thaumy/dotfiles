{ inputs, config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  rsbin = inputs.rsbin.packages.${pkgs.system};
in
{
  home.packages = with rsbin; [
    (edit-config "cfg")
    (dup-img-finder "dif")
    (safe-remove "rr")
    (screenshot "ss")
    (vi-project "vp")
    (vi-visual-pane "vvp")
    (wm-action "wm")
    (sh-history-filter "shf")
  ];

  home.file = {
    ".config/rsbin/edit-config/config.toml".source = mkSymlink "${homeDir}/cfg/rsbin/edit-config/config.toml";
    ".config/dup-img-finder".source = mkSymlink "${homeDir}/cfg/dup-img-finder";
    ".config/sh-history-filter".source = mkSymlink "${homeDir}/cfg/sh-history-filter";
  };
}
