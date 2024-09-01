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
    (writeBin "rr" sh/safe-remove/run.rs)
    (writeBin "c-qc" sh/cargo/qc.sh)
    (writeBin "pwdc" sh/pwdc/run.sh)
    (writeBin "todo" sh/todo/run.sh)
    (writeBin "dimf" sh/dimf/run.sh)
    (writeBin "memdir" sh/memdir/run.sh)
    (writeBin "backup" sh/backup/run.sh)
    (writeBin "hashpwd" sh/hashpwd/run.sh)
    (writeBin "dir-flat" sh/dir-flat/run.sh)
    (writeBin "disable-kb" sh/disable-kb/run.sh)
    (writeBin "pic-search" sh/pic-search/run.sh)
    (writeBin "nvim-profiler" sh/nvim-profiler/run.rs)
    (writeBin "symlink-localize" sh/symlink-localize/run.sh)

    (writeBin "aes-en" sh/crypto/aes-en.sh)
    (writeBin "aes-de" sh/crypto/aes-de.sh)

    (writeBin "nix-gc" sh/nix/gc.sh)
    (writeBin "nix-chan-up" sh/nix/chan-up.sh)
    (writeBin "nix-flake-up" sh/nix/flake-up.sh)

    (writeBin "g-r" sh/git/rebase-10.sh)
    (writeBin "g-rr" sh/git/rebase-20.sh)
    (writeBin "g-rrr" sh/git/rebase-40.sh)
    (writeBin "g-rrrr" sh/git/rebase-80.sh)
    (writeBin "g-l" sh/git/log.sh)
    (writeBin "g-a" sh/git/add.sh)
    (writeBin "g-p" sh/git/push.sh)
    (writeBin "g-s" sh/git/status.sh)
    (writeBin "g-ap" sh/git/add-p.sh)
    (writeBin "g-br" sh/git/branch.sh)
    (writeBin "g-sw" sh/git/switch.sh)
    (writeBin "g-cm" sh/git/commit-m.sh)
    (writeBin "g-ce" sh/git/commit-e.sh)
    (writeBin "g-ra" sh/git/rebase-abort.sh)
    (writeBin "g-rc" sh/git/rebase-continue.sh)
    (writeBin "g-cpr" sh/git/checkout-pr.sh)
    (writeBin "g-can" sh/git/commit-amend-noedit.sh)

    (writeBin "wm-apps" sh/wm/apps.rs)
    (writeBin "wm-lock" sh/wm/lock.rs)
    (writeBin "wm-menu" sh/wm/menu.rs)
    (writeBin "wm-switch-ws" sh/wm/switch-ws.rs)
    (writeBin "wm-win-to-ws" sh/wm/win-to-ws.rs)
  ];
}
