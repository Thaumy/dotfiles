{ pkgs, ... }: {
  services.nginx = {
    enable = true;
    package = pkgs.openresty;
  };
}
