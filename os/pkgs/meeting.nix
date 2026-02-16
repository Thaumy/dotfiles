{ pkgs, ... }:
let
  zoom-us = ((import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/0c19708cf035f50d28eb4b2b8e7a79d4dc52f6bb.tar.gz";
    sha256 = "0ngw2shvl24swam5pzhcs9hvbwrgzsbcdlhpvzqc7nfk8lc28sp3";
  })) {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  }).zoom-us;
in
[
  zoom-us
  #pkgs.nur.repos.novel2430.wemeet-bin-bwrap-wayland-screenshare
]
