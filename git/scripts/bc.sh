#!/usr/bin/env dash

set -e

NORM='\033[0m'
GREEN='\033[32m'

NAME=$(git b --show-current)
echo -n "$NAME" | wl-copy

echo "\n${GREEN}󰜴 branch name copied${NORM}"
