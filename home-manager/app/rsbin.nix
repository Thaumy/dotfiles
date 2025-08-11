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
    (wm-action "wm")
  ];

  home.file = {
    ".config/rsbin/edit-config/config.toml".source = mkSymlink "${homeDir}/cfg/rsbin/edit-config/config.toml";
    ".config/dup-img-finder".source = mkSymlink "${homeDir}/cfg/dup-img-finder";
  };
}
