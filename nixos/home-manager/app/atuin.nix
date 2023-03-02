{ config, pkgs, ... }:

{
  programs.atuin = {
    enable = true;
    settings = {
      style = "compact";
      auto_sync = "false";
    };
  };
}
