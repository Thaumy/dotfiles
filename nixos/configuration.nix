{ ... }: {
  imports = [
    ./env.nix
    ./sec.nix
    ./boot.nix
    ./user.nix
    ./docs.nix
    ./pkgs.nix
    ./local.nix
    ./nixpkgs.nix
    ./app/mod.nix
    ./dev/mod.nix
    ./hardware.nix
    ./programs.nix
    ./services.nix
    ./networking.nix
    ./hardware-configuration.nix
  ];

  powerManagement.enable = true;

  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';

  #users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
