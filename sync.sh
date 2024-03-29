#!/usr/bin/env bash

set -e

declare home='/home/thaumy'
declare repo='/home/thaumy/dev/repo/thaumy/dotfiles'

# Fish
rm -rf "$repo/fish"
cp -r  "$home/cfg/fish" "$repo/fish"

# Neovim
rm -rf "$repo/neovim"
cp -r  "$home/cfg/neovim" "$repo/neovim"

# NixOS
rm -rf "$repo/nixos"
cp -r  "$home/cfg/nixos" "$repo/nixos"

# Home Manager
rm -rf "$repo/home-manager"
cp -r  "$home/cfg/home-manager" "$repo/home-manager"
