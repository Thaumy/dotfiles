{ ... }: {
  imports = [
    ./fish.nix
    #./netdata.nix
    ./yubikey.nix
    #./steam.nix
    #./tomcat.nix
    #./waydroid.nix
    ./openssh.nix
    ./udisks2.nix

    ./dae.nix
    ./upower.nix
    ./xserver.nix
    ./blueman.nix
    ./pipewire.nix
    ./hyprland.nix
    ./power-profiles-daemon.nix

    #./mysql.nix
    #./kafka.nix
    #./redis.nix
    ./postgres.nix
    #./mongodb.nix
    #./memcached.nix

    #./docker.nix
    ./virt-manager.nix
  ];
}
