{ pkgs, ... }: {
  services.dae = {
    enable = true;
    configFile = "/home/thaumy/cfg/dae/cfg.dae";

    openFirewall = {
      enable = true;
      port = 12345;
    };
    package = pkgs.dae;
    assets = with pkgs; [ v2ray-geoip v2ray-domain-list-community ];
  };
}
