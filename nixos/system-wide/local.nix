{ config, pkgs, ... }:

{

  fonts = {

    enableDefaultFonts = true;

    fonts = with pkgs;[
      nerdfonts
      noto-fonts
      sarasa-gothic
      jetbrains-mono
      liberation_ttf
      twemoji-color-font
    ];

    fontconfig.defaultFonts = {
      emoji = [ "Twitter Color Emoji" ];
      serif = [ "Liberation Serif" ];
      sansSerif = [ "Sarasa UI SC" ];
      monospace = [ "JetBrains Mono" ];
    };

  };

  i18n = 
  let
    locale = "en_US.UTF-8";
  in
  {

    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = [ pkgs.fcitx5-chinese-addons ];
    };

    defaultLocale = locale;

    extraLocaleSettings = {
      LC_NAME = locale;
      LC_TIME = locale;
      LC_PAPER = locale;
      LC_NUMERIC = locale;
      LC_ADDRESS = locale;
      LC_MONETARY = locale;
      LC_TELEPHONE = locale;
      LC_MEASUREMENT = locale;
      LC_IDENTIFICATION = locale;
    };

  };

  time.timeZone = "Asia/Shanghai";

}

