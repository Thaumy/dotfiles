{ config, pkgs, ... }:

let
  pkgs-22-11 = import <nixos-22.11> { config = { allowUnfree = true; }; };
  pkgs-23-05 = import <nixos-23.05> { config = { allowUnfree = true; }; };
in
{

  services.mysql = {
    enable = true;
    package = pkgs-22-11.mysql80;
  };

}
