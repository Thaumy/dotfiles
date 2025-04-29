{ pkgs, pkgs-24-05, ... }: {
  home.packages = with pkgs; [
    # nur
    #nur.repos.thaumy.idbuilder
    nur.repos.thaumy.microsoft-todo-electron
    nur.repos.novel2430.wemeet-bin-bwrap-wayland-screenshare
    #nur.repos.xddxdd.dingtalk

    # office
    pkgs-24-05.wpsoffice
    pkgs-24-05.libreoffice

    # editor
    # TODO: pin uncommonly used apps to ng stable version
    glow
    typst
    typstfmt
    #pkgs-24-05.android-studio

    # IM
    tdesktop
    element-desktop

    # WM
    wl-clipboard-x11
    whitesur-gtk-theme
    networkmanagerapplet

    # VCS
    gh
    git-lfs
    gitoxide
    github-desktop
    git-filter-repo

    # penetration
    #mdk4
    crunch
    macchanger
    aircrack-ng
    netdiscover
    wirelesstools

    # connectivity
    blueman

    # etc
    fio
    zip
    qrcp
    unar
    grim # screenshot
    hdparm
    udiskie
    xorg.xev # show key events
    gammastep
    steam-run
    ventoy-full
    qbittorrent
    rust-script
    any-nix-shell
    pkgs-24-05.postman
    nodePackages.ts-node
  ];
}
