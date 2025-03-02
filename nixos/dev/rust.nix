{ inputs, pkgs, ... }:
let
  toolchain = (pkgs.rust-bin.nightly."2025-02-27".complete.override {
    extensions = [ "rust-src" ];
    targets = [
      "aarch64-apple-darwin"
      "aarch64-unknown-linux-gnu"
      "aarch64-unknown-linux-musl"
      "x86_64-apple-darwin"
      "x86_64-pc-windows-msvc"
      "x86_64-unknown-linux-gnu"
      "x86_64-unknown-linux-musl"
      "wasm32-wasip1"
      "wasm32-wasip2"
      "wasm32-unknown-unknown"
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
