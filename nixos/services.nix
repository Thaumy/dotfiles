{ ... }: {
  services = {
    gvfs.enable = true;
    udisks2.enable = true;
    blueman.enable = true;
    printing.enable = true;
    #memcached.enable = true;
    power-profiles-daemon.enable = true;
  };
}
