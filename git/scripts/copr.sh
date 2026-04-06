#!/usr/bin/env dash

set -e

git fetch upstream "pull/$1/head:pr-$1"
git switch "pr-$1"
