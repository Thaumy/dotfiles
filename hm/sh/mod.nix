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
    (writeBin "sv" etc/sv.sh)
    (writeBin "pwdc" etc/pwdc.sh)
    (writeBin "todo" etc/todo.sh)
    (writeBin "pdif" etc/pdif.sh)
    (writeBin "nix-gc" nix/gc.sh)
    (writeBin "backup" backup/run.sh)
    (writeBin "memdir" etc/memdir.sh)
    (writeBin "hashpwd" etc/hashpwd.sh)
    (writeBin "dir-flat" etc/dir-flat.sh)
    (writeBin "disable-kb" etc/disable-kb.sh)
    (writeBin "pic-search" etc/pic-search.sh)
    (writeBin "cp-dirs-only" etc/cp-dirs-only.sh)
    (writeBin "gpg-gen-keys" etc/gpg-gen-keys.sh)
    (writeBin "symlink-localize" etc/symlink-localize.sh)

    (writeBin "huh" beep/huh.sh)
    (writeBin "bruh" beep/bruh.sh)

    (writeBin "aes-en" crypto/aes-en.sh)
    (writeBin "aes-de" crypto/aes-de.sh)
  ];
}
