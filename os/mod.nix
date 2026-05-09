_: {
  imports = [
    ./hw.nix
    ./env.nix
    ./boot.nix
    ./user.nix
    #./docs.nix
    ./pkgs.nix
    ./locale.nix
    ./hw-gen.nix
    ./app/mod.nix
    ./dev/mod.nix
    ./sec/mod.nix
    ./pkgs/mod.nix
    ./services.nix
    ./networking/mod.nix
  ];

  powerManagement.enable = true;
  system.stateVersion = "22.11";
}
