{ config, pkgs, ... }:

let
  stable-pkgs = import <nixos-22.11> { config = { allowUnfree = true; }; };

  rust = (pkgs.rust-bin.nightly."2023-06-09".default.override {
    extensions = [ "rust-src" ];
  });

  sdk = with pkgs;[
    go
    gcc
    jdk8
    rust
    ocaml
    redli
    redis
    stack
    jdk11
    jdk17
    redis
    docker
    nodejs
    gnumake
    kafkactl
    protobuf
    valgrind
    python311
    kubernetes
    clang-tools
    dotnet-sdk_7
    rust-bindgen
    android-tools
    llvmPackages_15.libllvm
    linuxKernel.packages.linux_6_1.perf
  ];

  infra = with pkgs;[
    jq
    exa
    git
    bat
    nmap
    wget
    tree
    htop
    procs
    p7zip
    xclip
    broot
    tokei
    podman
    bottom
    pstree
    evtest
    nixfmt
    du-dust
    libinput
    patchelf
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

      "app-homes/chromium".source = chromium;
      "app-homes/firefox".source = firefox;
      "app-homes/mysql".source = mysql80;
      "app-homes/pgsql".source = postgresql_15;
      "app-homes/mongodb".source = mongodb;
      "app-homes/kafka".source = apacheKafka_3_2;
      "app-homes/redis".source = redis;
    };
  };
}

