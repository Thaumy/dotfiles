{ pkgs-23-05, ... }: {
  services.mysql = {
    enable = true;
    package = pkgs-23-05.mysql80;
  };

  environment.etc = {
    "app-homes/mysql".source = pkgs-23-05.mysql80;
  };
}
