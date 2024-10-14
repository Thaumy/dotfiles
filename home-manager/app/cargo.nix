{ pkgs, ... }: {
  home.packages = with pkgs; [
    grcov
    cargo-edit
    cargo-udeps
    cargo-audit
    cargo-tauri
    cargo-expand
    cargo-nextest
    cargo-llvm-cov
    cargo-outdated
    cargo-generate
    cargo-component
  ];
}
