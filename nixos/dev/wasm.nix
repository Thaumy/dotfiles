{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    binaryen
    wasmtime
    wasm-pack
    wasm-tools
    wit-bindgen
    wasm-bindgen-cli
  ];
}
