{ config, pkgs, ... }:

{

  virtualisation.docker = {
    enable = true;
    #daemon.settings = {
    #  proxies = {
    #    http-proxy = "http://localhost:7890";
    #    https-proxy = "http://localhost:7890";
    #  };
    #};
  };

}
