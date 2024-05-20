{ ... }: {
  imports = [
    ./gpg.nix
    ./git.nix
    ./bash.nix
    ./fish.nix
    ./rofi.nix
    ./dconf.nix
    ./waybar.nix
    ./neovim.nix
    ./chromium.nix
    ./hyprland.nix
    ./alacritty.nix
    ./dup-img-finder.nix
    ./sh-history-filter.nix
  ];
}
