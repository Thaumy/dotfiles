{ ... }: {
  home.file."dif.toml".enable = true;
  home.file."dif.toml".text = ''
    [ignore]
    abs_path = [
      "/home/thaumy/.local",
      "/home/thaumy/.cache",
      "/home/thaumy/.config",
      "/home/thaumy/.dotnet",
      "/home/thaumy/.nix-defexpr",
      "/home/thaumy/.nix-profile",
      "/home/thaumy/.nuget",
      "/home/thaumy/.vscode",
      "/home/thaumy/.cargo",
      
      "/home/thaumy/Android",
      "/home/thaumy/caches",
      
      "/home/thaumy/dev/repo/cnblogs",
    ]
    regex = [
      "node_modules",
      ".stack-work",
      "target/debug",
      "target/release",
      "build/intermediates/packaged_res/debug",
    ]
  '';
}
