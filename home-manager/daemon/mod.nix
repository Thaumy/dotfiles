{ ... }: {
  imports = [
    #./auto-dark.nix
    #./clash-meta.nix
  ];

  systemd.user.startServices = true; # e.g. "legacy".
}
