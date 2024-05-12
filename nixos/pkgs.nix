{ pkgs, ... }:
let
  rust = (pkgs.rust-bin.nightly."2024-05-01".default.override {
    extensions = [ "rust-src" ];
    targets = [
      "aarch64-apple-darwin"
      "aarch64-unknown-linux-gnu"
      "aarch64-unknown-linux-musl"
      "x86_64-apple-darwin"
      "x86_64-pc-windows-msvc"
      "x86_64-unknown-linux-gnu"
      "x86_64-unknown-linux-musl"
      "wasm32-wasi"
      "wasm32-unknown-unknown"
    ];
  });

  sdk = with pkgs;[
    go
    jdk8
    rust
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
    rust-bindgen
    android-tools
    nodePackages_latest.yo
    nodePackages_latest.webpack
    nodePackages_latest.webpack-cli
    linuxKernel.packages.linux_6_8.perf
  ];

  lib = with pkgs;[
    openssl
    libvirt
    libinput
    libiconv
    llvmPackages_15.libllvm
  ];

  infra = with pkgs;[
    jq
    eza
    git
    bat
    glib
    nmap
    zbar
    lsof
    vsce
    wget
    qemu
    tree
    lshw
    htop
    bluez
    whois
    procs
    p7zip
    spice
    broot
    tokei
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
    nix-index
    inetutils
    dmidecode
    pkg-config
    smartmontools
    docker-compose
    nix-prefetch-github
    nix-prefetch-scripts
  ];

  etc = with pkgs;[
    vsftpd
    gparted
    firefox
    paperkey
    qrencode
    yarn2nix
    neofetch
    distrobox
    wireshark
    exfatprogs
    clash-meta
    cryptsetup
    obs-studio
    home-manager
    ffmpeg_5-full
    libsForQt5.qtstyleplugin-kvantum
  ];
in
{
  environment = {
    systemPackages =
      sdk ++
      lib ++
      infra ++
      etc;

    etc = with pkgs; {
      "sdk-homes/go".source = go;
      "sdk-homes/rust".source = rust;
      "sdk-homes/jdk8".source = jdk8;
      "sdk-homes/jdk-11".source = jdk11;
      "sdk-homes/jdk-17".source = jdk17;
      "sdk-homes/gcc-10".source = gcc10;
      "sdk-homes/gcc-13".source = gcc13;
      "sdk-homes/dotnet".source = dotnet-sdk_7;
      "sdk-homes/linux-headers".source = linuxHeaders;
      "sdk-homes/llvm".source = llvmPackages_15.libllvm;
      "sdk-homes/perf".source = linuxKernel.packages.linux_6_8.perf;

      "app-homes/firefox".source = firefox;
      "app-homes/chromium".source = chromium;
    };
  };
}

