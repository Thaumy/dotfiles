_: {
  imports = [
    ./shf-bash.nix
    ./shf-fish.nix
  ];

  systemd.user.startServices = true; # e.g. "legacy".
}
