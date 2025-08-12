{ pkgs, ... }: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_15;
    authentication = ''
      #type database  DBuser origin-address auth-method
      host  all       all    ::1/128        trust
      host  all       all    127.0.0.1/32   trust
    '';
  };

  environment.etc = {
    "app-homes/pgsql".source = pkgs.postgresql_15;
  };
}
