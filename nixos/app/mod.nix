_: {
  imports = [
    #./steam.nix
    #./tomcat.nix
    ./logind.nix
    ./systemd.nix
    #./netdata.nix
    #./openssh.nix
    #./waydroid.nix

    ./xdg.nix
    ./dae.nix
    ./hypr.nix
    ./upower.nix
    ./greetd.nix
    ./xserver.nix
    ./pipewire.nix

    #./nginx.nix
    #./mysql.nix
    #./kafka.nix
    #./redis.nix
    #./podman.nix
    ./sysstat.nix
    #./mongodb.nix
    #./postgres.nix
    #./influxdb.nix

    ./docker.nix
    ./virt-manager.nix
  ];
}
