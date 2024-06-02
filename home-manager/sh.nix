{ pkgs, ... }:
let
  writeBin = name: path: pkgs.writeTextFile {
    inherit name;
    executable = true;
    destination = "/bin/${name}";
    text = builtins.readFile path;
  };
in
{
  home.packages = [
    (writeBin "sr" sh/safe-remove/run.sh)
    (writeBin "pwdc" sh/pwdc/run.sh)
    (writeBin "memdir" sh/memdir/run.sh)
    (writeBin "backup" sh/backup/run.sh)
    (writeBin "dir-flat" sh/dir-flat/run.sh)
    (writeBin "disable-kb" sh/disable-kb/run.sh)
    (writeBin "pic-search" sh/pic-search/run.sh)
    (writeBin "up-proxy-sub" sh/up-proxy-sub/run.sh)
    (writeBin "symlink-localize" sh/symlink-localize/run.sh)
    (writeBin "archive-core-files" sh/archive-core-files/run.sh)

    (writeBin "aes-en" sh/crypto/aes-en.sh)
    (writeBin "aes-de" sh/crypto/aes-de.sh)

    (writeBin "nix-gc" sh/nix-gc/run.sh)
    (writeBin "nix-chan-up" sh/nix-chan-up/run.sh)
  ];
}
