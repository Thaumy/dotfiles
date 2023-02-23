final: prev:
let
  stable-pkgs = import <nixos-22.11> { config = { allowUnfree = true; }; };
in
{
  neovim = stable-pkgs.neovim;
}
