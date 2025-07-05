_: {
  imports = [
    ./fish.nix
    ./ccache.nix

    ./logind.nix
    ./systemd.nix
    #./openssh.nix
    #./waydroid.nix

    ./xdg.nix
    ./dae.nix
    ./hypr.nix
    ./dconf.nix
    ./upower.nix
    ./greetd.nix
    ./xserver.nix
    ./pipewire.nix

    #./nginx.nix
    #./kafka.nix
    #./redis.nix
    #./podman.nix
    ./sysstat.nix
    #./postgres.nix
    #./influxdb.nix

    ./docker.nix
    ./virt-manager.nix
  ];
}
