#!/usr/bin/env bash

rm -rf system-wide
rm -rf home-manager

mkdir system-wide
mkdir home-manager

cp -r $HOME/cfg/nixos/* system-wide
cp -r $HOME/cfg/home-manager/* home-manager

