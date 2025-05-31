{ inputs, pkgs, ... }: {
  imports = [ inputs.dae.nixosModules.dae ];

  services.dae = {
    enable = true;
    configFile = "/home/thaumy/cfg/dae/cfg.dae";

    openFirewall = {
      enable = true;
      port = 12345;
    };
    package = inputs.dae.packages.${pkgs.system}.dae-unstable;
    assets = with pkgs; [ v2ray-geoip v2ray-domain-list-community ];
  };
}
