{ ... }: {
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
    ./programs.nix
    ./services.nix
    ./networking/mod.nix
  ];

  powerManagement.enable = true;

  #users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
