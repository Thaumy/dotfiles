{ pkgs, ... }:
let
  toolchain = (pkgs.rust-bin.nightly."2024-06-20".complete.override {
    extensions = [ "rust-src" ];
    targets = [
      "aarch64-apple-darwin"
      "aarch64-unknown-linux-gnu"
      "aarch64-unknown-linux-musl"
      "x86_64-apple-darwin"
      "x86_64-pc-windows-msvc"
      "x86_64-unknown-linux-gnu"
      "x86_64-unknown-linux-musl"
      "wasm32-wasi"
      "wasm32-unknown-unknown"
    ];
  });
in
{
  environment = {
    systemPackages = with pkgs; [
      toolchain
      rust-bindgen
    ];

    etc."sdk-homes/rust".source = toolchain;
  };
}
