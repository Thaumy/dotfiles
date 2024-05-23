{ pkgs, ... }:
let
  shellBin = name: path: pkgs.writeShellScriptBin name (builtins.readFile path);
in
{
  home.packages = [
    (shellBin "sr" sh/safe-remove/run.sh)
    (shellBin "pwdc" sh/pwdc/run.sh)
    (shellBin "memdir" sh/memdir/run.sh)
    (shellBin "backup" sh/backup/run.sh)
    (shellBin "dir-flat" sh/dir-flat/run.sh)
    (shellBin "disable-kb" sh/disable-kb/run.sh)
    (shellBin "pic-search" sh/pic-search/run.sh)
    (shellBin "up-proxy-sub" sh/up-proxy-sub/run.sh)
    (shellBin "symlink-localize" sh/symlink-localize/run.sh)
    (shellBin "archive-core-files" sh/archive-core-files/run.sh)

    (shellBin "aes-en" sh/crypto/aes-en.sh)
    (shellBin "aes-de" sh/crypto/aes-de.sh)

    (shellBin "nix-gc" sh/nix-gc/run.sh)
    (shellBin "nix-chan-up" sh/nix-chan-up/run.sh)
  ];
}
