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
    (writeBin "vp" etc/vi-project.sh)
    (writeBin "rr" etc/safe-remove.rs)
    (writeBin "vvp" etc/vi-vis-pane.sh)
    (writeBin "pwdc" etc/pwdc.sh)
    (writeBin "todo" etc/todo.sh)
    (writeBin "dimf" etc/dimf.sh)
    (writeBin "memdir" etc/memdir.sh)
    (writeBin "hashpwd" etc/hashpwd.sh)
    (writeBin "dir-flat" etc/dir-flat.sh)
    (writeBin "disable-kb" etc/disable-kb.sh)
    (writeBin "pic-search" etc/pic-search.sh)
    (writeBin "cp-dirs-only" etc/cp-dirs-only.sh)
    (writeBin "gpg-gen-keys" etc/gpg-gen-keys.sh)
    (writeBin "symlink-localize" etc/symlink-localize.sh)

    (writeBin "backup" backup/run.sh)

    (writeBin "huh" beep/huh.sh)
    (writeBin "bruh" beep/bruh.sh)

    (writeBin "aes-en" crypto/aes-en.sh)
    (writeBin "aes-de" crypto/aes-de.sh)

    (writeBin "nix-gc" nix/gc.sh)

    (writeBin "wm-apps" wm/apps.rs)
    (writeBin "wm-lock" wm/lock.rs)
    (writeBin "wm-menu" wm/menu.rs)
    (writeBin "wm-switch-ws" wm/switch-ws.rs)
    (writeBin "wm-win-to-ws" wm/win-to-ws.rs)

    (writeBin "dk-cub" docker/compose-up-build.sh)
    (writeBin "dk-cdv" docker/compose-down-v.sh)
    (writeBin "dk-rmni" docker/rm-none-images.sh)
    (writeBin "dk-rmac" docker/rm-all-containers.sh)
    (writeBin "dk-cop-rst" docker/compose-restart.sh)
  ];
}
