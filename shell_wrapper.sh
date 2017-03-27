#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR
SCRIPT="./sentinel-notify-slack.rb"
CONFIG="config.yml"

# use noninteractive login shell to ensure rbenv/rvm works
bash -lc "$SCRIPT -c $CONFIG -- "$@""
