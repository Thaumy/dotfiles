{ inputs, pkgs, ... }:
let
  rust-toolchain = pkgs.rust-bin.nightly."2026-05-29".complete.override {
    extensions = [ "rust-src" ];
    targets = [
      "aarch64-unknown-linux-gnu"
      "aarch64-unknown-linux-musl"
      "x86_64-unknown-linux-gnu"
      "x86_64-unknown-linux-musl"
      "wasm32-unknown-unknown"
      "riscv32i-unknown-none-elf"
    ];
  };
in
{
  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];

  environment.systemPackages = with pkgs; [
    grcov
    rust-bindgen
    rust-toolchain

    cargo-udeps
    cargo-audit
    cargo-expand
    cargo-nextest
    cargo-modules
    cargo-llvm-cov
    cargo-outdated
    cargo-generate
    cargo-show-asm
  ];
}
