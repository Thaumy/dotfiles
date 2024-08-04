{ pkgs, ... }:
let
  sdk = with pkgs; [
    go
    gdb
    jdk8
    lldb
    jdk11
    jdk17
    gcc10
    gcc13
    ocaml
    redli
    stack
    docker
    nodejs
    gnumake
    kafkactl
    protobuf
    valgrind
    python311
    sysfsutils
    kubernetes
    clang-tools
    linuxHeaders
    dotnet-sdk_7
    android-tools
    nodePackages_latest.yo
    nodePackages_latest.webpack
    nodePackages_latest.webpack-cli
    linuxKernel.packages.linux_6_9.perf
  ];

  lib = with pkgs; [
    glibc
    openssl
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
    docker-compose
    nvtopPackages.amd
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
    home-manager
    ffmpeg_5-full
    systemctl-tui
    libsForQt5.qtstyleplugin-kvantum
  ];
in
{
  environment = {
    systemPackages =
      sdk ++
      lib ++
      infra ++
      net ++
      fs ++
      etc;

    etc = with pkgs; {
      "sdk-homes/go".source = go;
      "sdk-homes/jdk8".source = jdk8;
      "sdk-homes/jdk-11".source = jdk11;
      "sdk-homes/jdk-17".source = jdk17;
      "sdk-homes/gcc-10".source = gcc10;
      "sdk-homes/gcc-13".source = gcc13;
      "sdk-homes/dotnet".source = dotnet-sdk_7;
      "sdk-homes/linux-headers".source = linuxHeaders;
      "sdk-homes/llvm".source = llvmPackages_15.libllvm;
      "sdk-homes/perf".source = linuxKernel.packages.linux_6_9.perf;

      "app-homes/firefox".source = firefox;
      "app-homes/chromium".source = chromium;
    };
  };
}
