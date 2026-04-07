#!/usr/bin/env dash

set -e

BOLD='\033[1m'
NORM='\033[0m'
GREEN='\033[32m'
PURPLE='\033[35m'

panic() {
  huh
  exit
}

hl() {
  echo "${GREEN}󰜴 ${BOLD}${PURPLE}$1${NORM}"
}

hl "cargo build --workspace --offline"
if ! cargo build --workspace --offline; then
  panic
fi

hl "cargo fmt --check"
if ! cargo fmt --check; then
  panic
else
  echo "    ${BOLD}${GREEN}PASS${NORM}"
fi

hl "cargo clippy --workspace --tests --offline -- -D warnings"
if ! cargo clippy --workspace --tests --offline -- -D warnings; then
  panic
fi

hl "cargo nextest run --workspace --offline"
if ! cargo nextest run --workspace --offline; then
  panic
fi

hl "cargo audit"
if ! cargo audit; then
  panic
fi

bruh
