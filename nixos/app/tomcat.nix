{ pkgs, ... }: {
  services.tomcat = {
    enable = true;
    package = pkgs.tomcat10;
  };

  environment.etc = {
    "sdk-homes/tomcat".source = pkgs.tomcat10;
  };
}
