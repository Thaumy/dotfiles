{ pkgs, ... }:
let
  sdk = with pkgs; [
    go
    gdb
    ocaml
    stack
    valgrind
    python312
    pax-utils
    sysfsutils
    android-tools
  ];

  infra = with pkgs; [
    qrencode
    libiconv
    unixtools.xxd

    fd
    bat
    eza
    glib
    lsof
    qemu
    lshw
    bluez
    procs
    cmake
    crunch
    xxHash
    evtest
    psmisc
    hdparm
    libvirt
    openssl
    pamixer
    numactl
    usbutils
    pciutils
    patchelf
    libinput
    cdrtools
    graphviz
    steam-run
    dmidecode
    watchexec
    vulkan-tools
    inotify-tools
    uutils-findutils
    uutils-diffutils
    uutils-coreutils-noprefix
  ];

  fs = with pkgs; [
    wimlib
    parted
    gparted
    exfatprogs
    cryptsetup
    smartmontools
  ];

  net = with pkgs; [
    hurl
    nmap
    wget
    mdk4
    whois
    grpcurl
    inetutils
    wireshark
    macchanger
    netdiscover
    aircrack-ng
    wirelesstools

    ((import (pkgs.fetchFromGitHub {
      owner = "nixos";
      repo = "nixpkgs";
      rev = "nixos-24.05";
      hash = "sha256-OnSAY7XDSx7CtDoqNh8jwVwh4xNL/2HaJxGjryLWzX8=";
    })) {
      system = pkgs.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    }).postman
  ];

  etc = with pkgs; [
    xev
    mutt
    tmux
    grim
    devenv
    udiskie
    blueman
    paperkey
    gammastep
    alacritty
    fastfetch
    shellcheck
    qbittorrent
    home-manager
    any-nix-shell
    systemctl-tui
    wl-clipboard-rs
    whitesur-gtk-theme
    networkmanagerapplet
    libsForQt5.qtstyleplugin-kvantum

    ((import (pkgs.fetchFromGitHub {
      owner = "nixos";
      repo = "nixpkgs";
      rev = "nixos-24.05";
      hash = "sha256-OnSAY7XDSx7CtDoqNh8jwVwh4xNL/2HaJxGjryLWzX8=";
    })) {
      system = pkgs.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    }).jetbrains.datagrip
  ];
in
{
  environment.systemPackages =
    fs ++
    etc ++
    net ++
    sdk ++
    infra;
}
