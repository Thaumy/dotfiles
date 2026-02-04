{ pkgs, ... }:
let
  pkgs-25-05 = pkgs.callPackage
    (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/refs/heads/nixos-25.05.tar.gz";
      sha256 = "0v6bd1xk8a2aal83karlvc853x44dg1n4nk08jg3dajqyy0s98np";
    })
    { };
in
with pkgs; [
  glow
  typst
  lychee
  typstyle
  pkgs-25-05.wpsoffice
  pkgs-25-05.libreoffice
]
