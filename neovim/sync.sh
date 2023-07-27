#!/usr/bin/env bash

rm -rf lua
rm -rf init.lua

cp -r $HOME/cfg/neovim/init.lua .
cp -r $HOME/cfg/neovim/lua .

