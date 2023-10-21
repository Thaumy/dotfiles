{ pkgs, ... }: {
  systemd.user.services."clash-daemon" = {
    Service = {
      Type = "simple";
      Restart = "always";
      ExecStart = "${pkgs.clash}/bin/clash -d /home/thaumy/cfg/clash";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
