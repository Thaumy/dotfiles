{ ... }:
let
  cfg = ''
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
      "/home/thaumy/Pictures/ehentai",

      "/home/thaumy/Pictures/img/16",
      "/home/thaumy/Pictures/img/17",
      "/home/thaumy/Pictures/img/19",
      "/home/thaumy/Pictures/img/20",
      "/home/thaumy/Pictures/img/21",

      "/home/thaumy/Documents/blog",
      "/home/thaumy/Android",
      "/home/thaumy/dev",
      "/home/thaumy/caches",
      "/home/thaumy/design",
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
  home.file.".config/dup-img-finder/cfg.toml" = {
    enable = true;
    text = cfg;
  };
}
