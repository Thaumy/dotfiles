{ config, pkgs, ... }:

let
  stable-pkgs = import <nixos-22.11> { config = { allowUnfree = true; }; };

  sdk = with pkgs;[
    go
    jdk
    gcc
    ocaml
    stack
    nodejs
    python39
    clang-tools
    dotnet-sdk_7
    android-tools
    (rust-bin.nightly."2023-01-11".default.override {
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

  db = with pkgs;[
    mysql80
    postgresql_15
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
    docker
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
    db ++
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
