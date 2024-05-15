{ inputs, ... }: [
  inputs.nur.overlay
  inputs.rust-overlay.overlays.default
  #(import ./vscode.nix)
  (import ./chromium.nix)
  #(import ./github-desktop.nix)
]
