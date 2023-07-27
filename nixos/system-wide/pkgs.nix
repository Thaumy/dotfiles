{ config, pkgs, ... }:

let
  pkgs-22-11 = import <nixos-22.11> { config = { allowUnfree = true; }; };
  pkgs-23-05 = import <nixos-23.05> { config = { allowUnfree = true; }; };

  rust = (pkgs.rust-bin.nightly."2023-06-09".default.override {
    extensions = [ "rust-src" ];
    targets = [ "wasm32-unknown-unknown" ];
  });

  sdk = with pkgs;[
    go
    gcc
    jdk8
    rust
    vsce
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
    wasm-pack
    kubernetes
    clang-tools
    dotnet-sdk_7
    rust-bindgen
    android-tools
    docker-compose
    wasm-bindgen-cli
    nodePackages_latest.yo
    nodePackages_latest.webpack
    nodePackages_latest.webpack-cli
    linuxKernel.packages.linux_6_1.perf
  ];

  lib = with pkgs;[
    libvirt
    libinput
    llvmPackages_15.libllvm
  ];

  infra = with pkgs;[
    jq
    exa
    git
    bat
    nmap
    zbar
    lsof
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
    podman
    bottom
    pstree
    evtest
    psmisc
    nixfmt
    du-dust
    patchelf
    win-spice
    nix-index
    steam-run
    pkg-config
    nixpkgs-fmt
    smartmontools
    nix-prefetch-github
  ];

  sec = with pkgs;[
    openssl
    paperkey
    yubikey-manager
    yubikey-personalization
  ];

  etc = with pkgs;[
    vlc
    clash
    vsftpd
    gparted
    firefox
    qrencode
    yarn2nix
    neofetch
    chromium
    distrobox
    wireshark
    obs-studio
    home-manager
    ffmpeg_5-full

    gnome.mutter
    gnome.gnome-boxes
    gnome.gnome-tweaks
    gnome.gnome-terminal
  ];
in
{
  environment = {
    systemPackages =
      sdk ++
      lib ++
      infra ++
      sec ++
      etc;

    gnome.excludePackages = with pkgs;[
      kgx
      epiphany
      gnome-tour
      gnome.yelp
      gnome.totem
      gnome.gnome-maps
      gnome.gnome-music
      gnome.simple-scan
      gnome.gnome-clocks
      gnome.gnome-weather
      gnome.gnome-calendar
      gnome.gnome-contacts
    ];

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

