{ pkgs, ... }:
let
  sdk = with pkgs; [
    go
    gdb
    lldb
    ocaml
    stack
    gcc14
    libllvm
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

  infra = with pkgs; [
    jq
    qrencode
    libiconv
    unixtools.xxd

    tree
    dutree
    pstree
    du-dust

    htop
    bottom
    nvtopPackages.full
    (btop.override { cudaSupport = true; rocmSupport = true; })

    fd
    eza
    git
    glib
    zbar
    lsof
    qemu
    lshw
    bluez
    procs
    p7zip
    spice
    broot
    tokei
    xxHash
    evtest
    psmisc
    screen
    ripgrep
    libvirt
    openssl
    pamixer
    numactl
    sysstat
    usbutils
    pciutils
    patchelf
    libinput
    cdrtools
    win-spice
    dmidecode
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
    grpcurl
    inetutils
    wireshark
  ];

  etc = with pkgs; [
    vsftpd
    firefox
    paperkey
    fastfetch
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
      etc ++
      net ++
      sdk ++
      infra;

    etc = with pkgs; {
      "sdk-homes/go".source = go;
      "sdk-homes/gcc".source = gcc14;
      "sdk-homes/llvm".source = libllvm;
      "sdk-homes/perf".source = linuxKernel.packages.linux_6_10.perf;
      "sdk-homes/linux-headers".source = linuxHeaders;

      "app-homes/firefox".source = firefox;
      "app-homes/chromium".source = chromium;
    };
  };
}
