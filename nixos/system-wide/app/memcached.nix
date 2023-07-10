{ config, pkgs, ... }:

{

  services.memcached = {
    enable = true;
  };

}
