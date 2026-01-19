{ inputs, pkgs, ... }:
let
  toolchain = (pkgs.rust-bin.nightly."2026-01-18".complete.override {
    extensions = [ "rust-src" ];
    targets = [
      "aarch64-apple-darwin"
      "aarch64-unknown-linux-gnu"
      "aarch64-unknown-linux-musl"
      "x86_64-unknown-linux-gnu"
      "x86_64-unknown-linux-musl"
      "wasm32-unknown-unknown"
      "riscv32i-unknown-none-elf"
    ];
  });
in
{
  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];

  environment = {
    systemPackages = with pkgs; [
      toolchain
      diesel-cli
      rust-bindgen

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
      cargo-show-asm
      cargo-component
    ];

    etc."sdk-homes/rust".source = toolchain;
  };
}
