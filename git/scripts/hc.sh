#!/usr/bin/env bash

declare NORM='\033[0m'
declare GREEN='\033[32m'

declare HASH
HASH=$(git rev-parse HEAD)
echo -n "$HASH" | wl-copy

git show --stat

echo -e "\n${GREEN}󰜴 commit hash copied${NORM}"
