#!/usr/bin/env bash

set -e

declare home='/home/thaumy'
declare repo='/home/thaumy/dev/repo/thaumy/dotfiles'

# Alacritty
rm -rf "$repo/alacritty"
cp -r  "$home/cfg/alacritty" "$repo/alacritty"

# Fish
rm -rf "$repo/fish"
cp -r  "$home/cfg/fish" "$repo/fish"

# Rofi
rm -rf "$repo/rofi"
cp -r  "$home/cfg/rofi" "$repo/rofi"

# Neovim
rm -rf "$repo/neovim"
cp -r  "$home/cfg/neovim" "$repo/neovim"

# Waybar
rm -rf "$repo/waybar"
cp -r  "$home/cfg/waybar" "$repo/waybar"

# Mako
rm -rf "$repo/mako"
cp -r  "$home/cfg/mako" "$repo/mako"

# NixOS
rm -rf "$repo/nixos"
cp -r  "$home/cfg/nixos" "$repo/nixos"

# Home Manager
rm -rf "$repo/home-manager"
cp -r  "$home/cfg/home-manager" "$repo/home-manager"
find "$repo/home-manager/sh" -maxdepth 1 -mindepth 1 \
  | grep -v "mod.nix" \
  | xargs rm -rf
