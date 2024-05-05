{ pkgs, ... }: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
  };

  environment.etc = {
    "app-homes/pgsql".source = pkgs.postgresql_15;
  };
}
