{ config, pkgs, ... }:

{
  imports = [
    ./app/gpg.nix
    ./app/git.nix
    ./app/bash.nix
    ./app/fish.nix
    ./app/neovim.nix
  ];
}
