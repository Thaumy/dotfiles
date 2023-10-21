{ ... }: {
  services.tomcat = {
    enable = true;
    package = pkgs.tomcat10;
  };
}
