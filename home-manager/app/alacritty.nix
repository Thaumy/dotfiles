{ config, pkgs, ... }:
let
  homeDir = config.home.homeDirectory;
  wrapper-script = pkgs.writeShellScriptBin "wrapper-script" ''
    declare color_scheme=$(dconf read /org/gnome/desktop/interface/color-scheme)
    if [ "$color_scheme" = "'light'" ] ; then
      ${pkgs.alacritty}/bin/alacritty \
        --config-file=${homeDir}/cfg/alacritty/light.toml \
        "$@"
    else
      ${pkgs.alacritty}/bin/alacritty \
        --config-file=${homeDir}/cfg/alacritty/dark.toml \
        "$@"
    fi
  '';
  alacritty-wrapped = pkgs.symlinkJoin {
    name = "alacritty";
    paths = [ pkgs.alacritty wrapper-script ];
    postBuild = ''
      cd $out/bin
      mv wrapper-script alacritty
    '';
  };
in
{
  home = {
    packages = [
      alacritty-wrapped
    ];
  };
}
