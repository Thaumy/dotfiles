#!/usr/bin/env bash

if [ "$1" = 'v' ]; then
  if [ "$2" = 'n' ]; then
    exec nvim --cmd 'cd ~/cfg/home-manager/app' ~/cfg/home-manager/app/neovim.nix
  else
    exec nvim --cmd 'cd ~/cfg/neovim' ~/cfg/neovim/init.lua
  fi
fi

if [ "$1" = 'os' ]; then
  exec nvim --cmd 'cd ~/cfg/nixos' ~/cfg/nixos/flake.nix
fi

if [ "$1" = 'hm' ]; then
  if [ "$2" = 'sh' ]; then
    exec nvim --cmd 'cd ~/cfg/home-manager/sh' ~/cfg/home-manager/sh/mod.nix
  else
    exec nvim --cmd 'cd ~/cfg/home-manager' ~/cfg/home-manager/flake.nix
  fi
fi

if [ "$1" = 'mx' ]; then
  exec nvim --cmd 'cd ~/cfg/tmux' ~/cfg/tmux/tmux.conf
fi

if [ "$1" = 'bat' ]; then
  exec nvim --cmd 'cd ~/cfg/bat' ~/cfg/bat/config
fi

if [ "$1" = 'ssh' ]; then
  exec nvim --cmd 'cd ~/cfg/ssh' ~/cfg/ssh/thaumy.conf
fi

if [ "$1" = 'cfg' ]; then
  exec nvim --cmd 'cd ~/cfg/home-manager/sh/etc' ~/cfg/home-manager/sh/etc/cfg.sh
fi

if [ "$1" = 'mpv' ]; then
  exec nvim --cmd 'cd ~/cfg/mpv' ~/cfg/mpv/input.conf
fi

if [ "$1" = 'dae' ]; then
  exec nvim --cmd 'cd ~/cfg/dae' ~/cfg/dae/cfg.dae
fi

if [ "$1" = 'shf' ]; then
  exec nvim --cmd 'cd ~/cfg/sh-history-filter' ~/cfg/sh-history-filter/cfg.toml
fi

if [ "$1" = 'git' ]; then
  exec nvim --cmd 'cd ~/cfg/git' ~/cfg/git/config.ini
fi

if [ "$1" = 'fish' ]; then
  exec nvim --cmd 'cd ~/cfg/fish' ~/cfg/fish/interactive.fish
fi

if [ "$1" = 'dimf' ]; then
  exec nvim --cmd 'cd ~/cfg/dup-img-finder' ~/cfg/dup-img-finder/cfg.toml
fi

if [ "$1" = 'hypr' ]; then
  exec nvim --cmd 'cd ~/cfg/hypr' ~/cfg/hypr/hyprland/hyprland.conf
fi

if [ "$1" = 'cargo' ]; then
  exec nvim --cmd 'cd ~/cfg/cargo' ~/cfg/cargo/config.toml
fi

if [ "$1" = 'waybar' ]; then
  exec nvim --cmd 'cd ~/cfg/waybar' ~/cfg/waybar/config.json
fi

if [ "$1" = 'alacritty' ]; then
  exec nvim --cmd 'cd ~/cfg/alacritty' ~/cfg/alacritty/config.toml
fi
