{ ... }: {
  imports = [
    #./steam.nix
    ./direnv.nix
    #./tomcat.nix
    #./netdata.nix
    ./openssh.nix
    #./waydroid.nix

    ./xdg.nix
    ./dae.nix
    ./upower.nix
    ./greetd.nix
    ./xserver.nix
    ./pipewire.nix

    ./nginx.nix
    #./mysql.nix
    #./kafka.nix
    #./redis.nix
    #./podman.nix
    #./mongodb.nix
    ./postgres.nix

    ./docker.nix
    ./virt-manager.nix
  ];
}
