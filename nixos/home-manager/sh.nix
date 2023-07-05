{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellScriptBin "aes-en"
      (builtins.readFile /home/thaumy/sh/crypto/aes-en.sh))
    (writeShellScriptBin "aes-de"
      (builtins.readFile /home/thaumy/sh/crypto/aes-de.sh))
    (writeShellScriptBin "memdir"
      (builtins.readFile /home/thaumy/sh/memdir/run.sh))
    (writeShellScriptBin "backup"
      (builtins.readFile /home/thaumy/sh/backup/run.sh))
    (writeShellScriptBin "pic-search"
      (builtins.readFile /home/thaumy/sh/pic-search/run.sh))
    (writeShellScriptBin "disable-kb"
      (builtins.readFile /home/thaumy/sh/disable-kb/run.sh))
    (writeShellScriptBin "up-proxy-sub"
      (builtins.readFile /home/thaumy/sh/up-proxy-sub/run.sh))
    (writeShellScriptBin "archive-core-files"
      (builtins.readFile /home/thaumy/sh/archive-core-files/run.sh))
    (writeShellScriptBin "soft-link-localize"
      (builtins.readFile /home/thaumy/sh/soft-link-localize/run.sh))
  ];
}
