final: prev:
let
  sh = prev.writeShellScriptBin "chromium-auto-dark" ''
    declare color_scheme="$(gsettings get org.gnome.desktop.interface color-scheme)"
    if [[ $color_scheme =~ 'dark' ]] then
      ${prev.chromium}/bin/chromium \
        --enable-features=WebContentsForceDark \
        "$@"
    else
      ${prev.chromium}/bin/chromium \
        "$@"
    fi
  '';
in
{
  chromium = prev.symlinkJoin {
    name = "chromium";
    paths = [ prev.chromium sh ];
    postBuild = ''
      cd $out/bin
      mv chromium-auto-dark chromium
    '';
  };
}
