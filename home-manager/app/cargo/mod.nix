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
    packages = [
      (writeBin "cargo-qc" ./qc.sh)
    ];

    file.".cargo/config.toml" = {
      enable = true;
      source = mkSymlink "${homeDir}/cfg/cargo/config.toml";
    };
  };
}
