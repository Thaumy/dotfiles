{ pkgs, ... }:
let
  shellBin = name: path: pkgs.writeShellScriptBin name (builtins.readFile path);
in
{
  home.packages = [
    (shellBin "aes-en" /home/thaumy/sh/crypto/aes-en.sh)
    (shellBin "aes-de" /home/thaumy/sh/crypto/aes-de.sh)
    (shellBin "archive-core-files" /home/thaumy/sh/archive-core-files/run.sh)
    (shellBin "backup" /home/thaumy/sh/backup/run.sh)
    (shellBin "dir-flat" /home/thaumy/sh/dir-flat/run.sh)
    (shellBin "disable-kb" /home/thaumy/sh/disable-kb/run.sh)
    (shellBin "memdir" /home/thaumy/sh/memdir/run.sh)
    (shellBin "pic-search" /home/thaumy/sh/pic-search/run.sh)
    (shellBin "pwdc" /home/thaumy/sh/pwdc/run.sh)
    (shellBin "symlink-localize" /home/thaumy/sh/symlink-localize/run.sh)
    (shellBin "sr" /home/thaumy/sh/safe-remove/run.sh)
    (shellBin "up-proxy-sub" /home/thaumy/sh/up-proxy-sub/run.sh)
    (shellBin "nix-gc" /home/thaumy/sh/nix-gc/run.sh)
    (shellBin "nix-chan-up" /home/thaumy/sh/nix-chan-up/run.sh)
  ];
}
