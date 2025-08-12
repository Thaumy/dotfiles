#!/usr/bin/env bash

declare INFO
INFO="$1"

set -e

mkdir -p log
mkdir -p pub
mkdir -p pri

export GNUPGHOME='gpg-home'
mkdir -p "$GNUPGHOME"
chmod 700 "$GNUPGHOME"

declare PASSPHRASE
PASSPHRASE="$(uuidgen -r | rg '^.*-.*-.*-(.*)$' -r '$1')"

function gpg-batch() {
  gpg --batch --pinentry-mode loopback --passphrase "$PASSPHRASE" "$@"
}

function fp() {
  rg "\[GNUPG:\] KEY_CREATED $1 (.*)" -r '$1' "$2"
}

gpg-batch \
  --status-file log/SC.log \
  --quick-generate-key "$INFO" ed25519 sign never

declare P_FP
P_FP="$(fp P log/SC.log)"

gpg --armor --export "$P_FP!" >"pub/SC.pub"

gpg-batch \
  --armor \
  --export-secret-keys "$P_FP!" >"pri/SC.pri"

qrencode -r "pri/SC.pri" -o "pri/SC.pri.svg"

function subkey() {
  gpg-batch \
    --status-file "log/$4.log" \
    --quick-add-key "$P_FP" "$1" "$2" "$3"

  declare FP
  FP="$(fp S "log/$4.log")"

  gpg --armor --export "$FP!" >"pub/$4.pub"

  gpg-batch \
    --armor \
    --export-secret-subkeys "$FP!" >"pri/$4.pri"

  qrencode -r "pri/$4.pri" -o "pri/$4.pri.svg"
}

subkey ed25519 sign never S
subkey ed25519 auth never A
subkey cv25519 encrypt never E

gpg --export-ssh-key "$(fp S log/A.log)!" >ssh

echo ''

gpg --list-secret-keys \
  --keyid-format 0xlong \
  --fingerprint \
  --with-keygrip "$P_FP"

rm -rf log
rm -rf "$GNUPGHOME"

echo "passphrase:"
echo "$PASSPHRASE"
