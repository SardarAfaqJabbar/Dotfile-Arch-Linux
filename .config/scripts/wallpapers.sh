#!/usr/bin/env bash

WALLPAPER_DIR=~/Pictures/wallpapers
INDEX_FILE=~/.cache/wal/wallpaper_index

# Get all wallpapers sorted
mapfile -t WALLS < <(find "$WALLPAPER_DIR" -type f | sort)
TOTAL=${#WALLS[@]}

# Read current index
INDEX=$(cat "$INDEX_FILE" 2>/dev/null || echo 0)

# Increment
INDEX=$(( (INDEX + 1) % TOTAL ))

# Save index
echo "$INDEX" > "$INDEX_FILE"

NEXT="${WALLS[$INDEX]}"

swww img "$NEXT" \
  --transition-type fade \
  --transition-duration 1 \
  --transition-fps 60

wal -i "$NEXT"