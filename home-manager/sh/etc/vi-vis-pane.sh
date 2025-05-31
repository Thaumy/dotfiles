#!/usr/bin/env bash

if [ "$1" = 'a' ]; then
  tmux capture-pane -pS - >/tmp/tmux-vis-pane-dump
else
  tmux capture-pane -p >/tmp/tmux-vis-pane-dump
fi

exec nvim /tmp/tmux-vis-pane-dump
