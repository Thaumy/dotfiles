{ ... }: {
  imports = [
    #./netdata.nix
    ./yubikey.nix
    #./steam.nix
    #./tomcat.nix
    #./waydroid.nix
    ./openssh.nix

    ./dae.nix
    ./upower.nix
    ./greetd.nix
    ./xserver.nix
    ./pipewire.nix
    ./hyprland.nix

    #./mysql.nix
    #./kafka.nix
    #./redis.nix
    ./postgres.nix
    #./mongodb.nix

    #./docker.nix
    ./virt-manager.nix
  ];
}
