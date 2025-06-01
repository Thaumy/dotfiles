{ pkgs, config, ... }:
let
  sdk = with pkgs; [
    go
    gdb
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
    bat
    eza
    zip
    glib
    lsof
    qemu
    lshw
    bluez
    procs
    p7zip
    broot
    tokei
    cmake
    crunch
    xxHash
    evtest
    psmisc
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
    cdrtools
    steam-run
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
    mdk4
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
    wl-clipboard-rs
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
