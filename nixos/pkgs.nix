{ pkgs, ... }:
let
  sdk = with pkgs; [
    go
    gdb
    lldb
    gcc10
    gcc13
    ocaml
    stack
    gnumake
    protobuf
    valgrind
    python311
    sysfsutils
    kubernetes
    clang-tools
    linuxHeaders
    android-tools
    linuxKernel.packages.linux_6_10.perf
  ];

  lib = with pkgs; [
    glibc
    libvirt
    libinput
    libiconv
    llvmPackages_15.libllvm
  ];

  infra = with pkgs; [
    jq
    eza
    git
    glib
    zbar
    lsof
    vsce
    qemu
    tree
    lshw
    htop
    bluez
    procs
    p7zip
    spice
    broot
    tokei
    xxHash
    dutree
    podman
    bottom
    pstree
    evtest
    psmisc
    screen
    openssl
    pamixer
    du-dust
    numactl
    sysstat
    usbutils
    pciutils
    patchelf
    cdrtools
    win-spice
    dmidecode
    pkg-config
    unixtools.xxd
    nvtopPackages.full
    (btop.override { cudaSupport = true; rocmSupport = true; })
  ];

  fs = with pkgs; [
    parted
    gparted
    exfatprogs
    cryptsetup
    smartmontools
  ];

  net = with pkgs; [
    nmap
    wget
    whois
    inetutils
    wireshark
  ];

  etc = with pkgs; [
    vsftpd
    ripgrep
    firefox
    paperkey
    qrencode
    neofetch
    distrobox
    obs-studio
    imagemagick
    home-manager
    ffmpeg_7-full
    systemctl-tui
    libsForQt5.qtstyleplugin-kvantum
  ];
in
{
  environment = {
    systemPackages =
      fs ++
      lib ++
      etc ++
      net ++
      sdk ++
      infra;

    etc = with pkgs; {
      "sdk-homes/go".source = go;
      "sdk-homes/llvm".source = llvmPackages_15.libllvm;
      "sdk-homes/perf".source = linuxKernel.packages.linux_6_10.perf;
      "sdk-homes/gcc-10".source = gcc10;
      "sdk-homes/gcc-13".source = gcc13;
      "sdk-homes/linux-headers".source = linuxHeaders;

      "app-homes/firefox".source = firefox;
      "app-homes/chromium".source = chromium;
    };
  };
}
