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

# NixOS
rm -rf "$repo/nixos"
cp -r  "$home/cfg/nixos" "$repo/nixos"

# Home Manager
rm -rf "$repo/home-manager"
cp -r  "$home/cfg/home-manager" "$repo/home-manager"
rm -rf "$repo/home-manager/sh"
