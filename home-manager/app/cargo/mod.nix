{ pkgs, config, ... }:
let
  homeDir = config.home.homeDirectory;
  mkSymlink = config.lib.file.mkOutOfStoreSymlink;
  writeBin = name: path: pkgs.writeTextFile {
    inherit name;
    executable = true;
    destination = "/bin/${name}";
    text = builtins.readFile path;
  };
in
{
  home = {
    packages = with pkgs; [
      grcov
      cargo-asm
      cargo-edit
      cargo-udeps
      cargo-audit
      cargo-tauri
      cargo-expand
      cargo-nextest
      cargo-llvm-cov
      cargo-outdated
      cargo-generate
      cargo-component
      (writeBin "cargo-qc" ./qc.sh)
    ];

    file.".cargo/config.toml" = {
      enable = true;
      source = mkSymlink "${homeDir}/cfg/cargo/config.toml";
    };
  };
}
