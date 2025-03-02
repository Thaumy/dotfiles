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
    paths = [ pkgs.ungoogled-chromium wrapper-script ];
    postBuild = ''
      cd $out/bin
      mv wrapper-script chromium
    '';
  };
  overlay = final: prev: {
    chromium = prev.chromium.override {
      commandLineArgs = "--enable-wayland-ime";
    };
  };
in
{
  home.packages = [ chromium-wrapped ];
  nixpkgs.overlays = [ overlay ];
}
