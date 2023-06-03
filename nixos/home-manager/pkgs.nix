{ config, pkgs, ... }:

let
  stable-pkgs = import <nixos-22.11> { config = { allowUnfree = true; }; };
in
{
  home.packages = with pkgs; [
    # nur
    nur.repos.thaumy.idbuilder
    nur.repos.linyinfeng.wemeet
    nur.repos.thaumy.microsoft-todo-electron

    # office
    stable-pkgs.wpsoffice
    stable-pkgs.libreoffice

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

    # etc
    gimp
    qrcp
    xmrig
    hdparm
    postman
    monero-gui
    ventoy-full
    github-desktop
    blackbox-terminal
  ];
}
