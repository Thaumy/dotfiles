{ ... }: {
  imports = [
    ./lf.nix
    ./ssh.nix
    ./xdg.nix
    ./gpg.nix
    ./git.nix
    ./bat.nix
    ./bash.nix
    ./fish.nix
    ./rofi.nix
    ./mako.nix
    ./dconf.nix
    ./gnome.nix
    ./waybar.nix
    ./neovim.nix
    ./chromium.nix
    ./hyprland.nix
    ./cargo/mod.nix
    ./alacritty.nix
    ./jetbrains.nix
    ./dup-img-finder.nix
    ./sh-history-filter.nix
  ];
}
