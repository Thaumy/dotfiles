{ ... }: {
  services.redis = {
    servers = {
      "my-redis".enable = true;
    };
  };
}
