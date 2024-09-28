#!/usr/bin/env bash

set -e

declare home='/home/thaumy'
declare repo='/home/thaumy/dev/repo/thaumy/dotfiles'

# git
rm -rf "$repo/git"
cp -r  "$home/cfg/git" "$repo/git"

# fish
rm -rf "$repo/fish"
cp -r  "$home/cfg/fish" "$repo/fish"

# rofi
rm -rf "$repo/rofi"
cp -r  "$home/cfg/rofi" "$repo/rofi"

# nvim
rm -rf "$repo/neovim"
cp -r  "$home/cfg/neovim" "$repo/neovim"

# mako
rm -rf "$repo/mako"
cp -r  "$home/cfg/mako" "$repo/mako"

# nixos
rm -rf "$repo/nixos"
cp -r  "$home/cfg/nixos" "$repo/nixos"

# waybar
rm -rf "$repo/waybar"
cp -r  "$home/cfg/waybar" "$repo/waybar"

# alacritty
rm -rf "$repo/alacritty"
cp -r  "$home/cfg/alacritty" "$repo/alacritty"

# home-manager
rm -rf "$repo/home-manager"
cp -r  "$home/cfg/home-manager" "$repo/home-manager"
