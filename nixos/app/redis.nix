{ pkgs, ... }: {
  services.redis = {
    servers = {
      "my-redis".enable = true;
    };
  };

  environment.etc = {
    "app-homes/redis".source = pkgs.redis;
  };
}
