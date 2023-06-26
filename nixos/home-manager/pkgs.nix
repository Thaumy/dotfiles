{ config, pkgs, ... }:

let
  pkgs-22-11 = import <nixos-22.11> { config = { allowUnfree = true; }; };
in
{
  home.packages = with pkgs; [
    # nur
    nur.repos.linyinfeng.wemeet
    nur.repos.thaumy.dup-img-finder
    nur.repos.thaumy.idbuilder
    nur.repos.thaumy.microsoft-todo-electron

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

    # etc
    gimp
    qrcp
    xmrig
    hdparm
    postman
    monero-gui
    ventoy-full
    qbittorrent
    pkgs-22-11.github-desktop
    blackbox-terminal

    # penetration
    mdk4
    macchanger
    aircrack-ng
    wirelesstools
  ];
}
