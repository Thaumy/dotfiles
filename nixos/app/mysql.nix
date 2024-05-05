{ ... }:
let
  pkgs-23-05 = import <nixos-23.05> { config = { allowUnfree = true; }; };
in
{
  services.mysql = {
    enable = true;
    package = pkgs-23-05.mysql80;
  };

  environment.etc = {
    "app-homes/mysql".source = pkgs.mysql80;
  };
}
