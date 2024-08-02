#!/bin/bash

onedrive --synchronize  > /dev/null 2>&1

if [[ $1 == "notification" ]]; then
  notify-send "OneDrive" > /dev/null 2>&1
fi

echo ""
