#!/usr/bin/env bash

FILE="$HOME/.cache/${KEY}.eww_launch.xyz"
STATUS_FILE="${FILE}.status"

if [ ! -f "$STATUS_FILE" ]; then
  eww open widget
  touch $STATUS_FILE
else
  rm "$STATUS_FILE"
  eww close widget
fi
