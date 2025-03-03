{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    biome
    nodejs
    nodePackages_latest.yo
    nodePackages_latest.webpack
  ];
}
