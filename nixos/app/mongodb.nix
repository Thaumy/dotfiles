{ pkgs, ... }: {
  services.mongodb.enable = true;

  environment.etc = {
    "app-homes/mongodb".source = pkgs.mongodb;
  };
}
