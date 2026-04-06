#!/usr/bin/env dash

NORM='\033[0m'
GREEN='\033[32m'

HASH=$(git rev-parse HEAD)
echo -n "$HASH" | wl-copy

git --no-pager show --stat

echo "\n${GREEN}󰜴 commit hash copied${NORM}"
