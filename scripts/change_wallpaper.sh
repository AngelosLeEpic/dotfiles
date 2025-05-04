#!/bin/bash

# Check if a wallpaper path was provided
wallpaper="$1"

if [ -z "$wallpaper" ]; then
    echo "Usage: $1 not found"
    exit 1
fi

# 1. Generate color scheme using wal
wal -i "$wallpaper" -n -e

# 2. Random transition selection for swww
transitions=("wipe" "grow" "outer" "center" "slide" "fade")
random_transition=${transitions[$RANDOM % ${#transitions[@]}]}

# 3. Set the new wallpaper with swww
swww img "$wallpaper" --transition-type "$random_transition" --transition-duration 3

# 4. Apply new wal colors to all kitty terminals
kitty @ set-colors --all ~/.cache/wal/colors-kitty.conf

# 5. Restart waybar to reload the new colors
killall -SIGUSR2 waybar

echo "  Wallpaper, Kitty, and Waybar updated with new Pywal colors!"
