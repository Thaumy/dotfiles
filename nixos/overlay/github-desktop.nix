final: prev:
let
  sh = prev.writeShellScriptBin "github-desktop-sh" ''
    ${prev.github-desktop}/bin/github-desktop
  '';
in
{
  github-desktop = prev.symlinkJoin {
    name = "github-desktop";
    paths = [ prev.github-desktop sh ];
    postBuild = ''
      cd $out/bin
      mv github-desktop-sh github-desktop
    '';
  };
}
