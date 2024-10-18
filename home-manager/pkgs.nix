{ pkgs, pkgs-24-05, ... }: {
  home.packages = with pkgs; [
    # nur
    nur.repos.thaumy.idbuilder
    nur.repos.thaumy.microsoft-todo-electron
    nur.repos.thaumy.mojave-dyn
    nur.repos.thaumy.catalina-dyn
    nur.repos.thaumy.bigsur-dyn
    nur.repos.linyinfeng.wemeet
    #nur.repos.xddxdd.dingtalk

    # office
    pkgs-24-05.wpsoffice
    pkgs-24-05.libreoffice

    # editor
    # TODO: pin uncommonly used apps to ng stable version
    glow
    typst
    typstfmt
    pkgs-24-05.android-studio

    # IM
    pkgs.feishu
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

    # wasm dev
    binaryen
    wasmtime
    wasm-pack
    wasm-tools
    wit-bindgen
    wasm-bindgen-cli

    # blockchain
    xmrig
    monero-gui

    # penetration
    mdk4
    crunch
    macchanger
    aircrack-ng
    netdiscover
    wirelesstools

    # connectivity
    blueman

    # etc
    fio
    mpv
    zip
    gimp
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
