{ ... }: {
  imports = [
    #./auto-dark.nix
  ];

  systemd.user.startServices = true; # e.g. "legacy".
}
