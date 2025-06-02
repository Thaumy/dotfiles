#!/usr/bin/env bash

if [ -z "$1" ]; then
  exec nvim "$XDG_DOCUMENTS_DIR/todo/_"
fi

if [ "$1" = 'o' ]; then
  exec nvim "$XDG_DOCUMENTS_DIR/todo/org"
fi

if [ "$1" = 'd' ]; then
  exec nvim "$XDG_DOCUMENTS_DIR/todo/dl"
fi
