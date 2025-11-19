{ pkgs, ... }:
let
  pkgs-24-05 = pkgs.callPackage
    (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/refs/heads/nixos-24.05.tar.gz";
      sha256 = "0zydsqiaz8qi4zd63zsb2gij2p614cgkcaisnk11wjy3nmiq0x1s";
    })
    { };
in
with pkgs; [
  glow
  typst
  lychee
  typstyle
  pkgs-24-05.wpsoffice
  pkgs-24-05.libreoffice
]
