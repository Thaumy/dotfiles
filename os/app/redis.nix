{ pkgs, ... }: {
  services.redis = {
    servers = {
      "my-redis".enable = true;
    };
  };

  environment = {
    systemPackages = [ pkgs.redli ];
    etc."app-homes/redis".source = pkgs.redis;
  };
}
