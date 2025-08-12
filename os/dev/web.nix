{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    biome
    nodejs
    openapi-generator-cli
    nodePackages_latest.yo
    nodePackages_latest.webpack
  ];
}
