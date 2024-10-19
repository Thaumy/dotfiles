#!/usr/bin/env bash

set -e

git branch "$1"
git switch "$1"
