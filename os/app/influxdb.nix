{ pkgs, ... }: {
  services.influxdb2.enable = true;

  environment = {
    systemPackages = [ pkgs.influxdb2 ];
  };
}
