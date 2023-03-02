{ config, pkgs, ... }:

{

  systemd.services.clash-daemon = {
    enable = true;
    after = [ "network.target" ];
    serviceConfig = {
      Type = "simple";
      Restart = "always";
      ExecStart = "${pkgs.clash}/bin/clash -d /home/thaumy/cfg/clash";
    };
    wantedBy = [ "multi-user.target" ];
  };

}
