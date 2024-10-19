#!/usr/bin/env bash

set -e

declare BOLD='\033[1m'
declare NORM='\033[0m'
declare GREEN='\033[32m'
declare PURPLE='\033[35m'

function hl {
  echo -e "${GREEN}󰜴 ${BOLD}${PURPLE}$1${NORM}"
}

hl "cargo b --workspace --offline"
cargo b --workspace --offline

hl "cargo fmt --check"
cargo fmt --check
echo -e "    ${BOLD}${GREEN}PASS${NORM}"

hl "cargo clippy --workspace --tests  --offline -- -D warnings"
cargo clippy --workspace --tests  --offline -- -D warnings

hl "cargo nextest run --workspace  --offline"
cargo nextest run --workspace  --offline

hl "cargo audit"
cargo audit

bruh
