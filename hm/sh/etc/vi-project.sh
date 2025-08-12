#!/usr/bin/env bash

if [ $# -eq 1 ]; then
  cd "$1" || exit
fi

if [ -f 'src/lib.rs' ]; then
  exec nvim 'src/lib.rs'
fi

if [ -f 'src/main.rs' ]; then
  exec nvim 'src/main.rs'
fi

if [ -f 'README.md' ]; then
  exec nvim 'README.md'
fi

if [ -f 'README' ]; then
  exec nvim 'README'
fi

if [ -f 'main.c' ]; then
  exec nvim 'main.c'
fi

if [ -f 'flake.nix' ]; then
  exec nvim 'flake.nix'
fi

echo 'unknown entrypoint'
