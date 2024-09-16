{ pkgs, ... }: {
  virtualisation.docker = {
    enable = true;
  };
  environment.systemPackages = with pkgs; [
    dive
    docker
    docker-slim
    docker-compose
  ];
}
