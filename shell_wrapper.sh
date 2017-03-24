#!/usr/bin/env sh
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR
SCRIPT="./sentinel-notify-slack.rb"
CONFIG="config.yml"

$SCRIPT -c $CONFIG -- "$@"
