{ pkgs, ... }:
let
  wrapper-script = pkgs.writeShellScriptBin "wrapper-script" ''
    declare color_scheme=$(dconf read /org/gnome/desktop/interface/color-scheme)
    if [ "$color_scheme" = "'light'" ] ; then
      ${pkgs.bat}/bin/bat \
        --style numbers \
        --theme OneHalfLight \
        "$@"
    else
      ${pkgs.bat}/bin/bat \
        --style numbers \
        --theme OneHalfDark \
        "$@"
    fi
  '';
  bat-wrapped = pkgs.symlinkJoin {
    name = "bat";
    paths = [ pkgs.bat wrapper-script ];
    postBuild = ''
      cd $out/bin
      mv wrapper-script bat
    '';
  };
in
{
  home.packages = [ bat-wrapped ];
}
