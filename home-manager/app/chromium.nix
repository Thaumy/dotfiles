{ pkgs, ... }:
let
  wrapper-script = pkgs.writeShellScriptBin "wrapper-script" ''
    declare color_scheme=$(dconf read /org/gnome/desktop/interface/color-scheme)
    if [ "$color_scheme" = "'light'" ] ; then
      ${pkgs.chromium}/bin/chromium \
        "$@"
    else
      ${pkgs.chromium}/bin/chromium \
        --enable-features=WebContentsForceDark \
        "$@"
    fi
  '';
  chromium-wrapped = pkgs.symlinkJoin {
    name = "chromium";
    paths = [ pkgs.chromium wrapper-script ];
    postBuild = ''
      cd $out/bin
      mv wrapper-script chromium
    '';
  };
in
{
  home = {
    packages = [
      chromium-wrapped
    ];
  };
}
