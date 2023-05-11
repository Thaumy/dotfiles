{ config, pkgs, ... }:

let
  stable-pkgs = import <nixos-22.11> { config = { allowUnfree = true; }; };

  sdk = with pkgs;[
    go
    jdk
    gcc
    jdk8
    ocaml
    stack
    jdk11
    jdk17
    redis
    docker
    nodejs
    gnumake
    valgrind
    python311
    clang-tools
    dotnet-sdk_7
    android-tools
    llvmPackages_15.libllvm
    linuxKernel.packages.linux_6_1.perf
    (rust-bin.nightly."2023-04-16".default.override {
      extensions = [ "rust-src" ];
    })
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

  environment.systemPackages =
    sdk ++
    infra ++
    sec ++
    etc;

  environment.gnome.excludePackages = with pkgs;[
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

}
