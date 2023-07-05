{ config, pkgs, ... }:

{

  services.apache-kafka = {
    enable = true;
  };

}
