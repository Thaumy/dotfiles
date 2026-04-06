#!/usr/bin/env dash

set -e

NORM='\033[0m'
GREEN='\033[32m'

tmux splitw -v -l 70% "nvim $*; tmux wait -S $$"

echo "\n${GREEN}tmux wait -S $$${NORM} to stop wait"
exec tmux wait "$$"
