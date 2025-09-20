#!/usr/bin/env bash

if [ "$1" = '-a' ]; then
  tmux capture-pane -pS -  | head -n -1 > /tmp/tmux-vis-pane-dump
else
  tmux capture-pane -pS -1 | head -n -1 > /tmp/tmux-vis-pane-dump
fi

exec nvim +'$|normal 3|' /tmp/tmux-vis-pane-dump
