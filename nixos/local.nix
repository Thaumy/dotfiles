{ pkgs, ... }: {
  fonts = {
    packages = with pkgs; [
      noto-fonts-emoji
      sarasa-gothic
      jetbrains-mono
      liberation_ttf
      material-design-icons
      (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];

    fontconfig.enable = true;
    fontconfig.defaultFonts = pkgs.lib.mkForce {
      emoji = [ "Noto Color Emoji" ];
      serif = [
        "Liberation Serif"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Sarasa UI SC"
        "Noto Color Emoji"
      ];
      monospace = [
        "JetBrains Mono"
        "Noto Color Emoji"
      ];
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

