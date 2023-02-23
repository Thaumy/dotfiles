final: prev:
let
  bin = "chromium";
  path = prev.chromium;
  args = toString [ "--force-dark-mode" ];
in {
  chromium = final.symlinkJoin {
    name = bin;
    paths = [ path ];
    buildInputs = [ final.makeWrapper ];
    postBuild = ''
      wrapProgram "$out/bin/${bin}" \
        --add-flags ${args}
    '';
  };
}