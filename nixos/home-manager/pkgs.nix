{ config, pkgs, ... }:

let
  stable-pkgs = import <nixos-22.11> { config = { allowUnfree = true; }; };
in
{
  home.packages = with pkgs;[
    # nur
    nur.repos.thaumy.idbuilder
    nur.repos.linyinfeng.wemeet
    nur.repos.thaumy.microsoft-todo-electron

    # sh
    (writeShellScriptBin "aes-en"
      (builtins.readFile /home/thaumy/sh/crypto/aes-en.sh))
    (writeShellScriptBin "aes-de"
      (builtins.readFile /home/thaumy/sh/crypto/aes-de.sh))
    (writeShellScriptBin "memdir"
      (builtins.readFile /home/thaumy/sh/memdir/run.sh))
    (writeShellScriptBin "backup"
      (builtins.readFile /home/thaumy/sh/backup/run.sh))
    (writeShellScriptBin "disable-kb"
      (builtins.readFile /home/thaumy/sh/disable-kb/run.sh))
    (writeShellScriptBin "update-clash-sub"
      (builtins.readFile /home/thaumy/sh/update-clash-sub/run.sh))

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
    tdesktop
    element-desktop

    # gnome ext
    gnomeExtensions.tiling-assistant
    gnomeExtensions.internet-speed-monitor

    # etc
    gimp
    xmrig
    steam
    postman
    monero-gui
    github-desktop
    blackbox-terminal
  ];
}
