{ ... }: {
  imports = [
    ./gpg.nix
    ./git.nix
    ./bash.nix
    ./fish.nix
    ./neovim.nix
    ./gnome/mod.nix
    ./alacritty.nix
    ./dup-img-finder.nix
    ./sh-history-filter.nix
  ];
}
