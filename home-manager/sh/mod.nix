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
    (writeBin "rr" etc/safe-remove.rs)
    (writeBin "cfg" etc/cfg.sh)
    (writeBin "pwdc" etc/pwdc.sh)
    (writeBin "todo" etc/todo.sh)
    (writeBin "dimf" etc/dimf.sh)
    (writeBin "memdir" etc/memdir.sh)
    (writeBin "hashpwd" etc/hashpwd.sh)
    (writeBin "dir-flat" etc/dir-flat.sh)
    (writeBin "disable-kb" etc/disable-kb.sh)
    (writeBin "pic-search" etc/pic-search.sh)
    (writeBin "cp-dirs-only" etc/cp-dirs-only.sh)
    (writeBin "nvim-profiler" etc/nvim-profiler.rs)
    (writeBin "symlink-localize" etc/symlink-localize.sh)

    (writeBin "c-qc" cargo/qc.sh)
    (writeBin "backup" backup/run.sh)

    (writeBin "huh" beep/huh.sh)
    (writeBin "bruh" beep/bruh.sh)

    (writeBin "aes-en" crypto/aes-en.sh)
    (writeBin "aes-de" crypto/aes-de.sh)

    (writeBin "nix-gc" nix/gc.sh)
    (writeBin "nix-chan-up" nix/chan-up.sh)
    (writeBin "nix-flake-up" nix/flake-up.sh)

    (writeBin "g-r" git/rebase-i-10.sh)
    (writeBin "g-rr" git/rebase-i-20.sh)
    (writeBin "g-rrr" git/rebase-i-40.sh)
    (writeBin "g-rrrr" git/rebase-i-80.sh)
    (writeBin "g-l" git/log.sh)
    (writeBin "g-rl" git/reflog.sh)
    (writeBin "g-a" git/add.sh)
    (writeBin "g-p" git/push.sh)
    (writeBin "g-f" git/fetch.sh)
    (writeBin "g-s" git/status.sh)
    (writeBin "g-ap" git/add-p.sh)
    (writeBin "g-rs" git/reset.sh)
    (writeBin "g-br" git/branch.sh)
    (writeBin "g-rb" git/rebase.sh)
    (writeBin "g-sw" git/switch.sh)
    (writeBin "g-cm" git/commit-m.sh)
    (writeBin "g-ce" git/commit-e.sh)
    (writeBin "g-ra" git/rebase-abort.sh)
    (writeBin "g-rc" git/rebase-continue.sh)
    (writeBin "g-cpr" git/checkout-pr.sh)
    (writeBin "g-cgh" git/clone-github.sh)
    (writeBin "g-can" git/commit-amend-noedit.sh)

    (writeBin "wm-apps" wm/apps.rs)
    (writeBin "wm-lock" wm/lock.rs)
    (writeBin "wm-menu" wm/menu.rs)
    (writeBin "wm-switch-ws" wm/switch-ws.rs)
    (writeBin "wm-win-to-ws" wm/win-to-ws.rs)

    (writeBin "dk-img-rmn" docker/images-rm-none.sh)
    (writeBin "dk-cop-rst" docker/compose-restart.sh)
    (writeBin "dk-con-rma" docker/containers-rm-all.sh)
  ];
}
