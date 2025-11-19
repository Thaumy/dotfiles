{ pkgs, ... }:
let
  sdk = with pkgs; [
    go
    gdb
    ocaml
    stack
    protobuf
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

    (pkgs.callPackage
      (pkgs.fetchFromGitHub {
        owner = "nixos";
        repo = "nixpkgs";
        rev = "nixos-24.05";
        hash = "sha256-OnSAY7XDSx7CtDoqNh8jwVwh4xNL/2HaJxGjryLWzX8=";
      })
      { }
    ).postman
  ];

  etc = with pkgs; [
    mutt
    tmux
    grim
    devenv
    udiskie
    blueman
    paperkey
    xorg.xev
    gammastep
    alacritty
    fastfetch
    shellcheck
    qbittorrent
    ollama-cuda
    home-manager
    any-nix-shell
    systemctl-tui
    wl-clipboard-rs
    whitesur-gtk-theme
    networkmanagerapplet
    libsForQt5.qtstyleplugin-kvantum

    (pkgs.callPackage
      (pkgs.fetchFromGitHub {
        owner = "nixos";
        repo = "nixpkgs";
        rev = "nixos-24.05";
        hash = "sha256-OnSAY7XDSx7CtDoqNh8jwVwh4xNL/2HaJxGjryLWzX8=";
      })
      { }
    ).jetbrains.datagrip
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
