{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nodejs
    nodePackages_latest.yo
    nodePackages_latest.webpack
    nodePackages_latest.webpack-cli
  ];
}
