{ ... }:
let cfg = ''
  [ignore]
  abs_path = [
    "/home/thaumy/.local",
    "/home/thaumy/.cache",
    "/home/thaumy/.config",
    "/home/thaumy/.dotnet",
    "/home/thaumy/.nix-defexpr",
    "/home/thaumy/.nix-profile",
    "/home/thaumy/.npm",
    "/home/thaumy/.nuget",
    "/home/thaumy/.vscode",
    "/home/thaumy/.cargo",
    "/home/thaumy/.gradle",

    "/home/thaumy/Android",
    "/home/thaumy/caches",
  ]
  regex = [
    "node_modules",
    ".stack-work",
    "target/debug",
    "target/release",
    "/home/thaumy/dev/repo/.*",
    "build/intermediates/packaged_res/debug",
  ]
'';
in
{
  #home.file."dif.toml" = {
  #  enable = true;
  #  text = cfg;
  #};
  home.file.".config/dup-img-finder/cfg.toml" = {
    enable = true;
    text = cfg;
  };
}
