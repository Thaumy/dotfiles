{ ... }: {
  imports = [
    #./steam.nix
    ./direnv.nix
    #./tomcat.nix
    #./netdata.nix
    #./openssh.nix
    #./waydroid.nix

    ./xdg.nix
    ./dae.nix
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
    ./postgres.nix
    ./influxdb.nix

    ./docker.nix
    ./virt-manager.nix
  ];
}
