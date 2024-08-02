#!/usr/bin/env bash

DaySuffix() {
  case $(date +%-d) in
  1 | 21 | 31) echo "st" ;;
  2 | 22) echo "nd" ;;
  3 | 23) echo "rd" ;;
  *) echo "th" ;;
  esac
}

if [ "$1" == "date" ]; then

  date=$(date "+%A %-d$(DaySuffix) %B %Y")
  icon=""
  printf "%s" "$date"
else
  echo ""
fi
