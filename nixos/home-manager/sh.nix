{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellScriptBin "aes-en"
      (builtins.readFile /home/thaumy/sh/crypto/aes-en.sh))
    (writeShellScriptBin "aes-de"
      (builtins.readFile /home/thaumy/sh/crypto/aes-de.sh))
    (writeShellScriptBin "archive-core-files"
      (builtins.readFile /home/thaumy/sh/archive-core-files/run.sh))
    (writeShellScriptBin "backup"
      (builtins.readFile /home/thaumy/sh/backup/run.sh))
    (writeShellScriptBin "dir-flat"
      (builtins.readFile /home/thaumy/sh/dir-flat/run.sh))
    (writeShellScriptBin "disable-kb"
      (builtins.readFile /home/thaumy/sh/disable-kb/run.sh))
    (writeShellScriptBin "memdir"
      (builtins.readFile /home/thaumy/sh/memdir/run.sh))
    (writeShellScriptBin "pic-search"
      (builtins.readFile /home/thaumy/sh/pic-search/run.sh))
    (writeShellScriptBin "pwdc"
      (builtins.readFile /home/thaumy/sh/pwdc/run.sh))
    (writeShellScriptBin "symlink-localize"
      (builtins.readFile /home/thaumy/sh/symlink-localize/run.sh))
    (writeShellScriptBin "sr"
      (builtins.readFile /home/thaumy/sh/safe-remove/run.sh))
    (writeShellScriptBin "up-proxy-sub"
      (builtins.readFile /home/thaumy/sh/up-proxy-sub/run.sh))
  ];
}
