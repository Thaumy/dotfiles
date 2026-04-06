#!/usr/bin/env dash

if [ -z "$1" ]; then
  exec nvim "$XDG_DOCUMENTS_DIR/todo/_"
fi

if [ "$1" = 'd' ]; then
  exec nvim "$XDG_DOCUMENTS_DIR/todo/dl"
fi
