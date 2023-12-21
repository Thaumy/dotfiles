final: prev:
let
  src = builtins.fetchTarball {
    url = "https://update.code.visualstudio.com/latest/linux-x64/insider";
    sha256 = "0f91vpwzz4y8mibvsz9dizyccymcc4badap5gr6wgaj8cpc8nb63";
  };
in
{
  vscode = (prev.vscode.override { isInsiders = true; }).overrideAttrs (old: {
    src = src;
    version = "latest";
  });
}
