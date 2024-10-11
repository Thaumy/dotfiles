{ pkgs, ... }: {
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      default-runtime = "crun";
      runtimes = {
        crun = { path = "${pkgs.crun}/bin/crun"; };
      };
    };
  };
  environment.systemPackages = with pkgs; [
    dive
    docker
    docker-slim
    docker-compose
  ];
}
