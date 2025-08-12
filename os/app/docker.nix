{ pkgs, ... }: {
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
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
    lazydocker
    docker-slim
    docker-compose
  ];
}
