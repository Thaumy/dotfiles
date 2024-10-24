#!/usr/bin/env bash

set -e

declare BOLD='\033[1m'
declare NORM='\033[0m'
declare GREEN='\033[32m'
declare PURPLE='\033[35m'

function panic {
  huh; exit
}

function hl {
  echo -e "${GREEN}󰜴 ${BOLD}${PURPLE}$1${NORM}"
}

hl  "cargo build --workspace --offline"
if ! cargo build --workspace --offline; then
  panic
fi

hl  "cargo fmt --check"
if ! cargo fmt --check; then
  panic
else
  echo -e "    ${BOLD}${GREEN}PASS${NORM}"
fi

hl  "cargo clippy --workspace --tests --offline -- -D warnings"
if ! cargo clippy --workspace --tests --offline -- -D warnings; then
  panic
fi

hl  "cargo nextest run --workspace --offline"
if ! cargo nextest run --workspace --offline; then
  panic
fi

hl  "cargo audit"
if ! cargo audit; then
  panic
fi

bruh
