#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

SCRIPT="./sentinel-notify-slack.rb"
CONFIG="config.yml"

TYPE=$1
TEXT="$2"

# use noninteractive login shell to ensure rbenv/rvm works
bash -lc -- "cd $DIR && $SCRIPT -c $CONFIG -- $TYPE \"$TEXT\""
