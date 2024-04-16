{ pkgs, ... }:
let
  pkgs-22-11 = import <nixos-22.11> { config = { allowUnfree = true; }; };
  pkgs-23-05 = import <nixos-23.05> { config = { allowUnfree = true; }; };
in
{
  home.packages = with pkgs; [
    # nur
    nur.repos.thaumy.dup-img-finder
    nur.repos.thaumy.idbuilder
    nur.repos.thaumy.microsoft-todo-electron
    nur.repos.thaumy.sh-history-filter
    nur.repos.thaumy.mojave-dyn
    nur.repos.thaumy.catalina-dyn
    nur.repos.thaumy.bigsur-dyn
    nur.repos.linyinfeng.wemeet
    #nur.repos.xddxdd.dingtalk

    # office
    pkgs-22-11.wpsoffice
    pkgs-23-05.libreoffice

    # editor
    # TODO: pin uncommonly used apps to ng stable version
    glow
    typst
    typstfmt
    vscode
    neovide
    android-studio
    pkgs-23-05.jetbrains.rider
    pkgs-23-05.jetbrains.clion
    pkgs-22-11.jetbrains.goland
    jetbrains.datagrip
    jetbrains.webstorm
    jetbrains.dataspell
    jetbrains.rust-rover
    pkgs-22-11.jetbrains.idea-ultimate
    pkgs-22-11.jetbrains.pycharm-professional

    # im
    feishu
    tdesktop
    element-desktop

    # gnome ext
    gnomeExtensions.tiling-assistant
    gnomeExtensions.internet-speed-monitor

    # git
    gh
    git-lfs
    git-filter-repo

    # dev
    fio
    netdata
    gitoxide
    binaryen
    wasmer
    wasmtime
    wasm-pack
    wasm-tools
    wit-bindgen
    wasm-bindgen-cli
    #pkgs-23-05.postman
    blackbox-terminal
    github-desktop

    # blockchain
    xmrig
    monero-gui

    # penetration
    mdk4
    macchanger
    aircrack-ng
    wirelesstools

    # etc
    zip
    gimp
    qrcp
    unar
    hdparm
    alacritty
    gammastep
    ventoy-full
    qbittorrent
    #gnome.dconf-editor
    steam-run
    nixpkgs-fmt
    wl-clipboard-x11

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
