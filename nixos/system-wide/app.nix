{ config, pkgs, ... }:

{

  imports = [
    ./app/clash.nix
    ./app/fish.nix
    ./app/steam.nix
    ./app/yubikey.nix
    #./app/tomcat.nix
    #./app/waydroid.nix

    ./app/mysql.nix
    #./app/postgres.nix
    #./app/mongodb.nix

    #./app/redis.nix
    #./app/memcached.nix
    #./app/kafka.nix
    ./app/docker.nix
  ];

}
