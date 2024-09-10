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
    (writeBin "rr" safe-remove/run.rs)
    (writeBin "c-qc" cargo/qc.sh)
    (writeBin "pwdc" pwdc/run.sh)
    (writeBin "todo" todo/run.sh)
    (writeBin "dimf" dimf/run.sh)
    (writeBin "memdir" memdir/run.sh)
    (writeBin "backup" backup/run.sh)
    (writeBin "hashpwd" hashpwd/run.sh)
    (writeBin "dir-flat" dir-flat/run.sh)
    (writeBin "disable-kb" disable-kb/run.sh)
    (writeBin "pic-search" pic-search/run.sh)
    (writeBin "nvim-profiler" nvim-profiler/run.rs)
    (writeBin "symlink-localize" symlink-localize/run.sh)

    (writeBin "aes-en" crypto/aes-en.sh)
    (writeBin "aes-de" crypto/aes-de.sh)

    (writeBin "nix-gc" nix/gc.sh)
    (writeBin "nix-chan-up" nix/chan-up.sh)
    (writeBin "nix-flake-up" nix/flake-up.sh)

    (writeBin "g-r" git/rebase-10.sh)
    (writeBin "g-rr" git/rebase-20.sh)
    (writeBin "g-rrr" git/rebase-40.sh)
    (writeBin "g-rrrr" git/rebase-80.sh)
    (writeBin "g-l" git/log.sh)
    (writeBin "g-rl" git/reflog.sh)
    (writeBin "g-a" git/add.sh)
    (writeBin "g-p" git/push.sh)
    (writeBin "g-s" git/status.sh)
    (writeBin "g-ap" git/add-p.sh)
    (writeBin "g-br" git/branch.sh)
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
  ];
}
