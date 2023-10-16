{ config, pkgs, ... }:

{
  imports = [
    ./app/clash.nix
    ./app/fish.nix
    ./app/gnome.nix
    #./app/steam.nix
    ./app/openssh.nix
    ./app/yubikey.nix
    #./app/tomcat.nix
    #./app/waydroid.nix

    #./app/mysql.nix
    ./app/postgres.nix
    #./app/mongodb.nix

    #./app/redis.nix
    #./app/memcached.nix
    #./app/kafka.nix
    ./app/docker.nix
    ./app/virt-manager.nix
  ];

}
