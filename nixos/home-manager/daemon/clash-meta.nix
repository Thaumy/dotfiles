{ pkgs, ... }: {
  systemd.user.services."clash-meta-daemon" = {
    Service = {
      Type = "simple";
      Restart = "always";
      ExecStart = "${pkgs.clash-meta}/bin/clash-meta -d /home/thaumy/cfg/clash-meta";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
