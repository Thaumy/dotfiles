{ config, pkgs, ... }:

let
  pkgs-22-11 = import <nixos-22.11> { config = { allowUnfree = true; }; };
  #pkgs-23-05 = import <nixos-23.05> { config = { allowUnfree = true; }; };
in
{
  home.packages = with pkgs; [
    # nur
    nur.repos.thaumy.dup-img-finder
    nur.repos.thaumy.idbuilder
    nur.repos.thaumy.microsoft-todo-electron
    nur.repos.linyinfeng.wemeet
    nur.repos.xddxdd.dingtalk

    # office
    pkgs-22-11.wpsoffice
    pkgs-22-11.libreoffice

    # editor
    glow
    vscode
    android-studio
    jetbrains.rider
    jetbrains.clion
    jetbrains.goland
    jetbrains.datagrip
    jetbrains.webstorm
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional

    # im
    feishu
    tdesktop
    element-desktop

    # gnome ext
    gnomeExtensions.tiling-assistant
    gnomeExtensions.internet-speed-monitor

    # git ext
    git-lfs
    git-filter-repo

    # dev
    postman
    blackbox-terminal
    pkgs-22-11.github-desktop

    # blockchain
    xmrig
    monero-gui

    # penetration
    mdk4
    macchanger
    aircrack-ng
    wirelesstools

    # etc
    gimp
    qrcp
    hdparm
    virtualbox
    ventoy-full
    qbittorrent
  ];
}
