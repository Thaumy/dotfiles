{ pkgs, config, ... }:
let
  sdk = with pkgs; [
    go
    gdb
    mold
    flex
    ocaml
    stack
    gcc14
    bison
    gnumake
    protobuf
    valgrind
    python312
    pax-utils
    sysfsutils
    kubernetes
    android-tools
    config.boot.kernelPackages.perf
  ];

  infra = with pkgs; [
    jq
    qrencode
    libiconv
    unixtools.xxd

    tree
    dutree
    pstree
    du-dust

    dool
    htop
    iotop
    bottom
    bandwhich
    nvtopPackages.full
    (btop.override { cudaSupport = true; rocmSupport = true; })

    sd
    fd
    fio
    bat
    eza
    zip
    unar
    glib
    zbar
    lsof
    qemu
    lshw
    qrcp
    bluez
    procs
    p7zip
    spice
    broot
    tokei
    cmake
    crunch
    xxHash
    evtest
    psmisc
    screen
    hdparm
    ripgrep
    libvirt
    openssl
    pamixer
    numactl
    usbutils
    pciutils
    patchelf
    libinput
    watchman
    cdrtools
    steam-run
    win-spice
    dmidecode
    tree-sitter
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
    whois
    grpcurl
    inetutils
    wireshark
    macchanger
    netdiscover
    aircrack-ng
    wirelesstools
  ];

  etc = with pkgs; [
    nh
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
    rust-script
    ollama-cuda
    home-manager
    any-nix-shell
    systemctl-tui
    whitesur-gtk-theme
    nodePackages.ts-node
    networkmanagerapplet
    libsForQt5.qtstyleplugin-kvantum
  ];
in
{
  environment = {
    systemPackages =
      fs ++
      etc ++
      net ++
      sdk ++
      infra;

    etc = with pkgs; {
      "sdk-homes/gcc".source = gcc14;

      "app-homes/firefox".source = firefox;
      "app-homes/chromium".source = chromium;
    };
  };
}
