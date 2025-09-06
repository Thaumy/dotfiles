{ pkgs, ... }: {
  fonts = {
    enableDefaultPackages = false;

    packages = with pkgs; [
      fira-code
      sarasa-gothic
      jetbrains-mono
      liberation_ttf
      noto-fonts-emoji
      source-han-serif
      times-newer-roman
      material-design-icons
      nerd-fonts.symbols-only
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
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
  };

  i18n = rec {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          fcitx5-gtk
          fcitx5-chinese-addons
          kdePackages.fcitx5-qt
        ];
      };
    };

    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_NAME = defaultLocale;
      LC_TIME = defaultLocale;
      LC_PAPER = defaultLocale;
      LC_NUMERIC = defaultLocale;
      LC_ADDRESS = defaultLocale;
      LC_MONETARY = defaultLocale;
      LC_TELEPHONE = defaultLocale;
      LC_MEASUREMENT = defaultLocale;
      LC_IDENTIFICATION = defaultLocale;
    };
  };

  time.timeZone = "Asia/Shanghai";
}
