{ pkgs, pkgs-24-05, ... }: {
  home.packages = with pkgs; [
    # nur
    #nur.repos.thaumy.idbuilder
    nur.repos.thaumy.microsoft-todo-electron
    #nur.repos.xddxdd.dingtalk

    # WM
    wl-clipboard-x11
    whitesur-gtk-theme
    networkmanagerapplet

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
