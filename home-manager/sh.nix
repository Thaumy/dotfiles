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
    (writeBin "todo" sh/todo/run.sh)
    (writeBin "memdir" sh/memdir/run.sh)
    (writeBin "backup" sh/backup/run.sh)
    (writeBin "hashpwd" sh/hashpwd/run.sh)
    (writeBin "dir-flat" sh/dir-flat/run.sh)
    (writeBin "disable-kb" sh/disable-kb/run.sh)
    (writeBin "pic-search" sh/pic-search/run.sh)
    (writeBin "up-proxy-sub" sh/up-proxy-sub/run.sh)
    (writeBin "nvim-profiler" sh/nvim-profiler/run.rs)
    (writeBin "symlink-localize" sh/symlink-localize/run.sh)
    (writeBin "archive-core-files" sh/archive-core-files/run.sh)

    (writeBin "aes-en" sh/crypto/aes-en.sh)
    (writeBin "aes-de" sh/crypto/aes-de.sh)

    (writeBin "nix-gc" sh/nix/gc.sh)
    (writeBin "nix-chan-up" sh/nix/chan-up.sh)
    (writeBin "nix-flake-up" sh/nix/flake-up.sh)

    (writeBin "g-r" sh/git/rebase-10.sh)
    (writeBin "g-rr" sh/git/rebase-20.sh)
    (writeBin "g-rrr" sh/git/rebase-40.sh)
    (writeBin "g-rrrr" sh/git/rebase-80.sh)
    (writeBin "g-a" sh/git/add.sh)
    (writeBin "g-p" sh/git/push.sh)
    (writeBin "g-s" sh/git/status.sh)
    (writeBin "g-d" sh/git/discard-all-changes.sh)
    (writeBin "g-ap" sh/git/add-p.sh)
    (writeBin "g-cm" sh/git/commit-m.sh)
    (writeBin "g-ra" sh/git/rebase-abort.sh)
    (writeBin "g-rc" sh/git/rebase-continue.sh)
    (writeBin "g-can" sh/git/commit-amend-noedit.sh)

    (writeBin "c-c" sh/cargo/clippy.sh)
    (writeBin "c-b" sh/cargo/build.sh)
    (writeBin "c-f" sh/cargo/fmt.sh)
    (writeBin "c-r" sh/cargo/run.sh)
    (writeBin "c-t" sh/cargo/test.sh)
    (writeBin "c-br" sh/cargo/build-r.sh)
    (writeBin "c-rr" sh/cargo/run-r.sh)
    (writeBin "c-tr" sh/cargo/test-r.sh)
    (writeBin "c-ct" sh/cargo/clippy-tests.sh)

    (writeBin "wm-lock" sh/wm/lock.rs)
    (writeBin "wm-menu" sh/wm/menu.rs)
    (writeBin "wm-switch-workspace" sh/wm/switch-workspace.rs)
    (writeBin "wm-win-to-workspace" sh/wm/win-to-workspace.rs)
  ];
}
