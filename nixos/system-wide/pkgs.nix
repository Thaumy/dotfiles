{ config, pkgs, ... }:

let
  pkgs-22-11 = import <nixos-22.11> { config = { allowUnfree = true; }; };
  pkgs-23-05 = import <nixos-23.05> { config = { allowUnfree = true; }; };

  rust = (pkgs.rust-bin.nightly."2023-09-06".default.override {
    extensions = [ "rust-src" ];
    targets = [
      "aarch64-apple-darwin"
      "aarch64-unknown-linux-gnu"
      "aarch64-unknown-linux-musl"
      "x86_64-apple-darwin"
      "x86_64-pc-windows-msvc"
      "x86_64-unknown-linux-gnu"
      "x86_64-unknown-linux-musl"
      "wasm32-unknown-unknown"
    ];
  });

  sdk = with pkgs;[
    go
    gcc
    jdk8
    rust
    ocaml
    redli
    stack
    jdk11
    jdk17
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
    dotnet-sdk_7
    rust-bindgen
    android-tools
    nodePackages_latest.yo
    nodePackages_latest.webpack
    nodePackages_latest.webpack-cli
    linuxKernel.packages.linux_6_5.perf
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
    nmap
    zbar
    lsof
    vsce
    wget
    qemu
    tree
    htop
    whois
    procs
    p7zip
    spice
    xclip
    broot
    tokei
    dutree
    podman
    bottom
    pstree
    evtest
    psmisc
    nixfmt
    screen
    du-dust
    sysstat
    pciutils
    patchelf
    cdrtools
    win-spice
    nix-index
    inetutils
    wasm-pack
    steam-run
    pkg-config
    nixpkgs-fmt
    smartmontools
    docker-compose
    wasm-bindgen-cli
    nix-prefetch-github
  ];

  etc = with pkgs;[
    vlc
    clash
    vsftpd
    gparted
    firefox
    paperkey
    qrencode
    yarn2nix
    neofetch
    chromium
    distrobox
    wireshark
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
      "sdk-homes/jdk11".source = jdk11;
      "sdk-homes/jdk17".source = jdk17;
      "sdk-homes/tomcat".source = tomcat10;
      "sdk-homes/dotnet".source = dotnet-sdk_7;
      "sdk-homes/llvm".source = llvmPackages_15.libllvm;
      "sdk-homes/perf".source = linuxKernel.packages.linux_6_1.perf;

      "app-homes/firefox".source = firefox;
      "app-homes/chromium".source = chromium;
      "app-homes/mysql".source = mysql80;
      #"app-homes/mongodb".source = mongodb;
      "app-homes/pgsql".source = postgresql_15;
      "app-homes/redis".source = redis;
      "app-homes/kafka".source = apacheKafka_3_2;
    };
  };
}

