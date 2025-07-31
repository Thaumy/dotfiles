{ inputs, config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  rsbin = inputs.rsbin.packages.${pkgs.system};
in
{
  home.packages = with rsbin; [
  ];
}
