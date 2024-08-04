{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    yarn2nix
    nix-index
    nix-prefetch-github
    nix-prefetch-scripts
  ];
}
