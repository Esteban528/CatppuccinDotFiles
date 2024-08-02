#!/usr/bin/env bash

# kill any running instances if they exist
eww kill

eww daemon

# start a bar for each monitor
# monitors=$(hyprctl monitors -j | jq '.[] | .id')
# monitors=$(hyprctl monitors -j | jq '.[] | .id' | wc -l)

eww open bar

sleep 5
bash $HOME/.config/scripts/volumecontrol

# eww open bar0
# if [ $monitors -gt 1 ]; then
# 	for ((i = 1 ; i <= $monitors ; i++)); do
# 		eww open bar${i}
# 	done
# fi
