{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    biome
    nodejs
    protobuf
    openapi-generator-cli
    nodePackages_latest.yo
  ];
}
