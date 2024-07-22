{ pkgs, pkgs-23-05, pkgs-23-11, pkgs-24-05, ... }:
{
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
    pkgs-23-05.wpsoffice
    pkgs-23-05.libreoffice

    # editor
    # TODO: pin uncommonly used apps to ng stable version
    glow
    typst
    typstfmt
    android-studio

    # JetBrains IDEs
    pkgs-24-05.jetbrains.rider
    pkgs-24-05.jetbrains.clion
    pkgs-24-05.jetbrains.goland
    pkgs-24-05.jetbrains.webstorm
    pkgs-24-05.jetbrains.datagrip
    pkgs-24-05.jetbrains.dataspell
    pkgs-24-05.jetbrains.rust-rover
    pkgs-24-05.jetbrains.idea-ultimate
    pkgs-24-05.jetbrains.pycharm-professional

    # IM
    pkgs-23-11.feishu
    tdesktop
    element-desktop

    # GNOME
    evince # docs reader
    rhythmbox
    gnome.eog
    gnome.sushi # file preview
    gnome.nautilus
    gnome.geary # mail
    gnome.dconf-editor
    gnome.gnome-tweaks
    gnome.gnome-calendar
    gnome.gnome-calculator
    gnome.gnome-font-viewer

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
    wasmer
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
    bottom
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

    # cargo
    grcov
    cargo-edit
    cargo-audit
    cargo-tauri
    cargo-expand
    cargo-outdated
    cargo-generate
    cargo-component
  ];
}
