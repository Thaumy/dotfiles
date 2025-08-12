#!/usr/bin/env bash

declare threads

if [ -z "$1" ]; then
  threads=$(nproc --ignore=1 --all)
else
  threads=$1
fi

declare log_file
log_file=$(date +'hashpwd-%y-%m-%d-%H:%M:%S.log')

find . -type f -print0 | sort -z | xargs -n 1 -P "$threads" -0 xxhsum -H32 | tee "$log_file"

sort "$log_file" -o "$log_file"

declare hash_all
hash_all=$(xxhsum -H128 "$log_file")

printf '\n%s\n' "$hash_all" | tee -a "$log_file"
