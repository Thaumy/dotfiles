{ config, pkgs, ... }:

{

  programs.git = {
    enable = true;
    userName = "Thaumy";
    userEmail = "thaumy@outlook.com";
    signing = {
      signByDefault = true;
      key = "9371 D49E 5DDF 58CC 9E8A  6CDD 8459 7965 A0D4 17A8";
    };
  };

}
